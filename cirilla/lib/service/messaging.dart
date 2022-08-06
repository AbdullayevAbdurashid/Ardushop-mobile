import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cirilla/service/helpers/request_helper.dart';
import 'package:cirilla/utils/debug.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPref;

Future<SharedPreferences> getSharedPref() async {
  return sharedPref ??= await SharedPreferences.getInstance();
}

/// Create a [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

/// Init Firebase service
Future<void> initializePushNotificationService() async {
  await Firebase.initializeApp();

  /// Subscribe to default topic
  await subscribeTopic(topic: kIsWeb ? 'web' : Platform.operatingSystem);

  if (!kIsWeb) {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}

/// Update token to database
Future<void> updateTokenToDatabase(
  RequestHelper requestHelper,
  String? token, {
  List<String>? topics,
}) async {
  try {
    if (topics != null) {
      await subscribeTopic(topic: topics);
    }
    await requestHelper.updateUserToken(token);
  } catch (e) {
    avoidPrint(
        '=========> Warning: Plugin Push Notifications Mobile And Web App Not Installed. Download here: https://wordpress.org/plugins/push-notification-mobile-and-web-app');
  }
}

/// Remove user token database
Future<void> removeTokenInDatabase(
  RequestHelper requestHelper,
  String? token,
  String? userId, {
  List<String>? topics,
}) async {
  try {
    if (topics != null) {
      await unSubscribeTopic(topic: topics);
    }
    await requestHelper.removeUserToken(token, userId);
  } catch (e) {
    avoidPrint(
        '=========> Warning: Plugin Push Notifications Mobile And Web App Not Installed. Download here: https://wordpress.org/plugins/push-notification-mobile-and-web-app');
  }
}

/// Get token
Future<String?> getToken() async {
  return await FirebaseMessaging.instance.getToken();
}

/// Subscribing to topics
Future<void> subscribeTopic({dynamic topic}) async {
  if (kIsWeb) return;

  if (topic is String) {
    avoidPrint("Subscribing to topics $topic");
    await FirebaseMessaging.instance.subscribeToTopic(topic);
  }
  if (topic is List<String>) {
    int i = 0;
    return Future.doWhile(() async {
      await FirebaseMessaging.instance.subscribeToTopic(topic[i]);
      avoidPrint("Subscribing to topics ${topic[i]}");
      i++;
      return i < topic.length;
    });
  }
}

/// Un subscribing to topics
Future<void> unSubscribeTopic({dynamic topic}) async {
  if (kIsWeb) return;

  if (topic is String) {
    avoidPrint("Un subscribing to topics $topic");
    await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
  }
  if (topic is List<String>) {
    int i = 0;
    return Future.doWhile(() async {
      await FirebaseMessaging.instance.unsubscribeFromTopic(topic[i]);
      avoidPrint("Un subscribing to topics ${topic[i]}");
      i++;
      return i < topic.length;
    });
  }
}

/// Listening the changes
mixin MessagingMixin<T extends StatefulWidget> on State<T> {
  Future<void> subscribe(RequestHelper requestHelper, Function navigate) async {
    if (kIsWeb || Platform.isIOS || Platform.isMacOS) {
      NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus != AuthorizationStatus.authorized &&
          settings.authorizationStatus != AuthorizationStatus.provisional) {
        return;
      }
    }

    // Any time the token refreshes, store this in the database too.
    FirebaseMessaging.instance.onTokenRefresh.listen((token) => updateTokenToDatabase(requestHelper, token));

    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message?.data != null) {
        try {
          Map<String, dynamic> data = {
            'type': message!.data['type'],
            'route': message.data['route'],
            'args': jsonDecode(message.data['args'])
          };
          navigate(data);
        } catch (e) {
          avoidPrint(e);
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
      if (message?.data != null) {
        try {
          Map<String, dynamic> data = {
            'type': message!.data['type'],
            'route': message.data['route'],
            'args': jsonDecode(message.data['args'])
          };
          navigate(data);
        } catch (e) {
          avoidPrint(e);
        }
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;

      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: 'launch_background',
              ),
            ));
      }
    });

    Timer(const Duration(seconds: 5), () async {
      // Get the token each time the application loads
      String? token = await getToken();
      avoidPrint("Token: $token");

      // Save the initial token to the database
      await updateTokenToDatabase(requestHelper, token);
    });
  }
}

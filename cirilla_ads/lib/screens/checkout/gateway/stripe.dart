import 'package:cirilla/mixins/app_bar_mixin.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:cirilla/webview_flutter.dart';

class StripeGateway extends StatefulWidget {
  final String publishableKey;

  const StripeGateway({Key? key, required this.publishableKey}) : super(key: key);

  @override
  State<StripeGateway> createState() => _StripeGatewayState();
}

class _StripeGatewayState extends State<StripeGateway> with AppBarMixin {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    String url = 'https://cirrilla-stripe-form.web.app?pk=${widget.publishableKey}';
    return Scaffold(
      appBar: baseStyleAppBar(context, title: "Payment"),
      body: SafeArea(
        child: WebView(
          initialUrl: url,
          javascriptMode: JavascriptMode.unrestricted,
          javascriptChannels: <JavascriptChannel>{
            _toasterJavascriptChannel(context),
          },
        ),
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
      name: 'Flutter_Cirilla',
      onMessageReceived: (JavascriptMessage message) {
        Navigator.pop(context, message.message);
      },
    );
  }
}

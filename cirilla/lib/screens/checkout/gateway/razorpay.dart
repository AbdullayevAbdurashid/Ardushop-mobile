import 'package:cirilla/utils/debug.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:cirilla/webview_flutter.dart';

class RazorpayGateway extends StatefulWidget {
  final dynamic data;

  const RazorpayGateway({Key? key, required this.data}) : super(key: key);

  @override
  State<RazorpayGateway> createState() => _RazorpayGatewayState();
}

class _RazorpayGatewayState extends State<RazorpayGateway> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    String url = widget.data['payment_result']['redirect_url'];
    return Scaffold(
      body: SafeArea(
        child: WebView(
          initialUrl: url,
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) {
            avoidPrint(request.url);
            if (request.url.contains('/order-received/')) {
              Navigator.of(context).pop('done');
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatelessWidget {
  bool isBlog;
  String appbarTitle;
  String urlWeb;
  WebviewPage(this.appbarTitle,this.urlWeb,{this.isBlog = false});

  final Completer<WebViewController> controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    print(urlWeb);

    return SafeArea(
      child: !isBlog?Scaffold(
        appBar: AppBar(
          title: Text(
            appbarTitle,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: WebView(
          initialUrl: urlWeb,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController){
            controller.complete(webViewController);
          },
        ),
      ):Scaffold(
        body: WebView(
          initialUrl: urlWeb,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController){
            controller.complete(webViewController);
          },
        ),
      ),
    );
  }
}

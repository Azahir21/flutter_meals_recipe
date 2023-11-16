import 'package:flutter/material.dart';
import 'package:mini_project/data/webview_arguments.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatelessWidget {
  static const routeName = '/web_view';
  final ArgumentsWebView components;
  const WebView(this.components);

  @override
  Widget build(BuildContext context) {
    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(
            const PlatformWebViewControllerCreationParams());
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(components.url));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(components.title),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}

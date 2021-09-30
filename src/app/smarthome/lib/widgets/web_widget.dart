import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebWidget extends StatelessWidget {
  WebWidget(this.url, this.label, {Key? key}) : super(key: key);

  final String label;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.label),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse(this.url),
        ),
        onWebViewCreated: (InAppWebViewController controller) {},
      ),
    );
  }
}

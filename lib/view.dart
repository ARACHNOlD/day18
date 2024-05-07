import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ViewPage extends StatelessWidget {
  final Uri url; // Make the url parameter final

  // Provide a key parameter to the super constructor
  const ViewPage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                  url: WebUri.uri(url)), // Use Uri.parse(url) to parse the URL
            ),
          ),
        ],
      ),
    );
  }
}

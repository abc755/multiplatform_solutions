import 'package:flutter/material.dart';
import 'dart:html';
import 'dart:ui' as ui;
import 'dart:math';

Widget webView(String link) => WebViewWidget(url: link);
class WebViewWidget extends StatelessWidget {
  final String url;

  const WebViewWidget({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    final id = Random().nextInt.toString();

    ui.platformViewRegister.registerViewFactory(id, (int viewId) => IFrameElement()..src = url);

    return HtmlElementView(viewType: id);
  }
}
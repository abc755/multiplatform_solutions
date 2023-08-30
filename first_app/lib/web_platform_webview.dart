import 'package:flutter/material.dart';
import 'dart:html';
import 'package:multiplatform_solutions/helpers/FakeUi.dart'
  if (dart.library.html) 'package:multiplatform_solutions/helpers/RealUi.dart' as ui;
import 'dart:math';

Widget webView(String link) => WebViewWidget(url: link);
class WebViewWidget extends StatelessWidget {
  final String url;

  const WebViewWidget({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    final id = Random().nextInt.toString();

    ui.platformViewRegistry.registerViewFactory(id, (int viewId) => IFrameElement()..src = url);
    
    return HtmlElementView(viewType: id);
  }
}
import 'dart:ui' as ui;

// ignore: camel_case_types
class PlatformViewRegistry {
  static registerViewFactory(String viewId, dynamic cb) {
    // ignore:undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(viewId, cb);
  }
}
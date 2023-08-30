import 'package:flutter/services.dart';

Future<String> fetchFileFromAssets(String assetsPath) async {
  return rootBundle.loadString(assetsPath).then((file) {
    return file.toString();
  }).catchError((error) {
    return 'файл не найден';
  });
}
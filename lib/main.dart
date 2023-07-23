import 'mock_webview.dart'
  if (dart.library.io) 'non_web_platform_webview.dart'
  if (dart.library.html) 'web_platform_webview.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final dio = Dio();
  final _url = TextEditingController();

  Future _loadData(url) async {
    if (url != null) {
      return await dio.get(url);
    }
  }

  @override
  void dispose() {
    _url.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: _url.text != ''
                ? FutureBuilder(
                    future: _loadData(_url.text),
                    builder: (context, snapshot) {
                      return snapshot.connectionState == ConnectionState.waiting
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : snapshot.hasError
                              ? Center(
                                  child: Text('Ошибка ${snapshot.error}'),
                                )
                              : snapshot.hasData
                                  ? Column(
                                      children: [
                                        Text(parse(snapshot.data.toString())
                                            .getElementsByTagName('title')
                                            .first
                                            .text),
                                        Text(
                                            'CORS Header: ${snapshot.data!.headers["access-control-allow-origin"] ?? "none"}'),
                                        Expanded(
                                            child:
                                                webView(_url.text)),
                                      ],
                                    )
                                  : const Center(child: Text('Нет данных'));
                    },
                  )
                : const Center(
                    child: Text('Введите адрес сайта'),
                  ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _url,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: const Text('LOAD'),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Text('App running on ${kIsWeb ? 'WEB' : Platform.operatingSystem}'),
          ),
        ],
      ),
    );
  }
}
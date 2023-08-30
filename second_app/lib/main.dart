import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:second_app/layouts/narrow_layout.dart';
import 'package:second_app/layouts/wide_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adaptive App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Adaptive App'),
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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints){
      return constraints.maxWidth > 720
          ? const WideLayout()
          : const NarrowLayout();
    });
  }
}

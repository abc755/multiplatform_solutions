import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'functions.dart';

class NarrowLayout extends StatelessWidget {
  const NarrowLayout({super.key});

  void _showCupertinoModalPopup(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: const Text('Выберите действие'),
          // message: Text('Mess'),
          actions: <Widget>[
            // List of actions
            CupertinoActionSheetAction(
              child: const Text('Посмотреть профиль'),
              onPressed: () {
                Navigator.pop(context); // Close the modal popup
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Посмотреть друзей'),
              onPressed: () {
                Navigator.pop(context); // Close the modal popup
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Сделать репорт данного человека'),
              onPressed: () {
                Navigator.pop(context); // Close the modal popup
              },
            )
          ],
          // A cancel button at the bottom of the modal popup
          cancelButton: CupertinoActionSheetAction(
            child: const Text('Закрыть'),
            onPressed: () {
              Navigator.pop(context); // Close the modal popup
            },
          ),
        ));
  }

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Adaptive App'),
      ),
      body: FutureBuilder(
          future: fetchFileFromAssets('assets/people_list.json'),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  return ListView(
                      children: jsonDecode(snapshot.data)
                          .map<Widget>((e) => ListTile(
                        leading: CircleAvatar(
                          radius: 35,
                          backgroundImage:
                          NetworkImage(e['avatar']),
                        ),
                        title: Text(e['name']),
                        subtitle: Text(e['position']),
                        onTap: () =>
                            _showCupertinoModalPopup(context),
                      ))
                          .toList());
                }
              default:
                return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

import 'functions.dart';

class WideLayout extends StatelessWidget {
  const WideLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.blue,
              child: const Column(
                children: [
                  Text('Adaptive App'),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: FutureBuilder(
                future: fetchFileFromAssets('assets/people_list.json'),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      } else {
                        return GridView(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisExtent: 150,
                            ),
                            children: jsonDecode(snapshot.data)
                                .map<Widget>((e) =>
                                    Builder(builder: (BuildContext context) {
                                      return GestureDetector(
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              radius: 50,
                                              backgroundImage:
                                                  NetworkImage(e['avatar']),
                                            ),
                                            Text(e['name']),
                                            Text(e['position'])
                                          ],
                                        ),
                                        onTap: () => showPopover(
                                          context: context,
                                          bodyBuilder: (context) =>
                                              const ListItems(),
                                          onPop: () =>
                                              print('Popover was popped!'),
                                          direction: PopoverDirection.top,
                                          width: 200,
                                          height: 200,
                                          arrowHeight: 15,
                                          arrowWidth: 30,
                                        ),
                                      );
                                    }))
                                .toList());
                      }
                    default:
                      return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ],
      ),
    );
  }
}

class ListItems extends StatelessWidget {
  const ListItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          Container(
            height: 50,
            color: Colors.amber[200],
            child: const Center(child: Text('Посмотреть профиль')),
          ),
          const Divider(),
          Container(
            height: 50,
            color: Colors.amber[300],
            child: const Center(child: Text('Посмотреть друзей')),
          ),
          const Divider(),
          Container(
            height: 50,
            color: Colors.amber[300],
            child: const Center(child: Text('Сделать репорт данного человека')),
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:pxlet_flutter_app/main.dart';
import 'package:pxlet_flutter_app/model/news.dart';
import 'package:pxlet_flutter_app/pages/detail.dart';

typedef Callback = void Function(NewsItem item);

ListTile makeListTile(NewsItem item, Callback callback) => ListTile(
    contentPadding:
        const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    title: Text(
      item.title,
      style: const TextStyle(
          color: Color(0xff17233d)),
    ),
    // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
    onTap: () {
      callback(item);
    },
    trailing:
        Icon(Icons.keyboard_arrow_right, color: MainThemeColor, size: 30.0));

Card makeCard(NewsItem item, Callback callback) => Card(
      elevation: 3.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        child: makeListTile(item, callback),
      ),
    );

class NewsList extends StatelessWidget {
  final List<NewsItem> list;
  const NewsList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
  
        itemBuilder: (context, index) {
          return makeCard(list[index], (item) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(url: item.url),
              ),
            );
          });
        },
        itemCount: list.length);
  }
}

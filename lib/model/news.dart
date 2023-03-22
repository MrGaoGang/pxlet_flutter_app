// To parse this JSON data, do
//
//     final newsItem = newsItemFromJson(jsonString);

import 'dart:convert';
import 'dart:math';

List<NewsItem> newsItemFromJson(String str) =>
    List<NewsItem>.from(json.decode(str).map((x) => NewsItem.fromJson(x)));

String newsItemToJson(List<NewsItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewsItem {
  NewsItem({
    required this.title,
    required this.url,
  });

  String title;
  String url;
  late String _id;

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    var item = NewsItem(
      title: json["title"],
      url: json["url"],
    );
    item._id = Random().nextInt(100000).toString();
    return item;
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "url": url,
      };
}

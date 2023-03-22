import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailPage extends StatefulWidget {
  String url = '';

  DetailPage({super.key, required this.url});
  @override
  DetailPageState createState() => DetailPageState(url: url);
}

class DetailPageState extends State<DetailPage> {
  String url = '';
  bool isLoading = true;
  final _key = UniqueKey();

  DetailPageState({required this.url});

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: url,
        key: _key,
        javascriptMode: JavascriptMode.unrestricted,
        onPageFinished: (url) {
          setState(() {
            isLoading = false;
          });
        },
        onProgress: (progress) async{
          print('webview loading progress = ${progress}');
          EasyLoading.showProgress(double.parse(progress.toString()) / 100,
              status: 'page loading ${(progress).toStringAsFixed(0)}%');
          if (progress >= 80) {
           await EasyLoading.dismiss();
          }
        },
      ));
  }
}

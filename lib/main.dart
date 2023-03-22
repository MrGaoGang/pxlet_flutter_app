import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:pxlet_flutter_app/const.dart';
import 'package:pxlet_flutter_app/components/news.dart';
import 'package:pxlet_flutter_app/model/news.dart';
import 'package:pxlet_flutter_app/services/index.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
    builder: EasyLoading.init(),
  ));
  easyloadingConfig();
}

void easyloadingConfig() {
  // set loading style
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.light
    ..maskType = EasyLoadingMaskType.custom
    ..maskColor = Color.fromARGB(125, 248, 248, 249)
    ..indicatorType = EasyLoadingIndicatorType.threeBounce
    ..indicatorColor = MainThemeColor
    ..progressWidth = 3
    ..textColor = MainThemeColor;
}

final MainThemeColor = Color(0xff2ec4b6);

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  String selectType = 'juejin';
  int _page = 0;
  late List<NewsItem> news = [];
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  List<BadgeTab> tabs = [];
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getNewsByType();
    allTopMenuTabs.forEach((element) {
      tabs.add(BadgeTab(text: element.title));
    });
    _tabController =
        new TabController(length: tabs.length, initialIndex: 0, vsync: this);
  }

  getNewsByType()  async{
    EasyLoading.show(status: 'loading ...');

    getNews(this.selectType, 20).then((value) {
      print('response ${this.selectType} and count = ${value.length}');
      setState(() {
        news = value;
      });
     EasyLoading.dismiss();
    }).catchError((e) {
      EasyLoading.dismiss();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 60.0,
          items: <Widget>[
            Icon(Icons.home, size: 30, color: Colors.white),
            Icon(Icons.perm_identity, size: 30, color: Colors.white),
          ],
          color: MainThemeColor,
          buttonBackgroundColor: MainThemeColor,
          backgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
        ),
        body: Container(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 30, 10, 20),
              child: Flex(
                direction: Axis.vertical,
                children: [
                  // 顶部tabs
                  BrnTabBar(
                    controller: _tabController,
                    tabs: tabs,
                    tabWidth: 80,
                    labelColor: MainThemeColor,
                    indicatorColor: MainThemeColor,
                    mode: BrnTabBarBadgeMode.origin,
                    labelPadding: const EdgeInsets.only(left: 20, right: 12),
                    indicatorPadding: const EdgeInsets.only(left: 10),
                    onTap: ((state, index) {
                      var type = allTopMenuTabs[index].name;
                      state.setState(() {
                        selectType = type;
                      });
                      this.getNewsByType();
                    }),
                  ),
                  // 文章列表
                  Expanded(child: NewsList(list: this.news))
                ],
              )),
          color: Colors.white,
        ));
  }
}

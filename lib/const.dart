
class ItemType {
  ItemType({
    required this.name,
    required this.title,
  });

  String name;
  String title;
}

typedef NewsTypeListClickCallback = void Function(String type);

List<ItemType> allTopMenuTabs = [
  ItemType(name: 'juejin', title: '掘金'),
  ItemType(name: 'hackernews', title: 'Hacker News'),
  ItemType(name: 'reddit', title: 'Reddit'),
  ItemType(name: 'devto', title: 'Dev.to'),
  ItemType(name: 'infoq', title: 'InfoQ'),
  ItemType(name: 'segmentfault', title: 'SegmentFault'),
  ItemType(name: 'techcrunch', title: 'Tech Crunch'),
  ItemType(name: 'krasia', title: 'KrAsia'),
  ItemType(name: '36kr', title: '36 Kr'),
];

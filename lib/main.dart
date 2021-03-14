import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: PersitentAppbar(
                appbarMaxHeight: 200,
                appBarMinHeight: 60,
              ),
              floating: true,
              pinned: true,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, index) => Items(
                  title: 'Item $index',
                ),
                childCount: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PersitentAppbar extends SliverPersistentHeaderDelegate {
  final double appbarMaxHeight;
  final double appBarMinHeight;

  final FloatingHeaderSnapConfiguration snap;
  PersitentAppbar(
      {this.appBarMinHeight, @required this.appbarMaxHeight, this.snap});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final firstBarOffset = (-shrinkOffset * 0.01) - shrinkOffset;
    final secondBarOffset = (-shrinkOffset * 0.01) - shrinkOffset + 60;

    return Container(
      color: Colors.white,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: secondBarOffset < -1.00 ? -1 : secondBarOffset,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Wrap(
                children: [
                  AppLogoWithText(),
                  // This shruck out of view
                  ExtendedItem(),
                ],
              ),
            ),
          ),
          Positioned(
            top: firstBarOffset,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Wrap(
                children: [
                  // This shruck out of view
                  ExtendedItem(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => appbarMaxHeight;

  @override
  double get minExtent => appBarMinHeight;

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => snap;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

class Items extends StatelessWidget {
  final String title;

  const Items({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(4),
      height: 100,
      width: width - 48,
      color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
      child: Text(
        title,
        style:
            Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
      ),
    );
  }
}

// you are allowed to break up this widget into smaller individual ones;
class ExtendedItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 8,
          ),
          Container(
            height: 50,
            width: width - 48,
            padding: const EdgeInsets.only(bottom: 8),
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}

class AppLogoWithText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Padding(
            padding: const EdgeInsets.only(left: 8), child: TitleTextSection()),
        const SizedBox(height: 4),
      ],
    );
  }
}

class TitleTextSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 8),
          height: 50,
          width: 50,
          color: Colors.black,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Sophisticated Scroll',
          ),
        ),
      ],
    );
  }
}

import 'dart:math';
import 'dart:ui';

import 'package:custom_tabbar/tabbar.dart';
import 'package:custom_tabbar/tabbarView.dart';
import 'package:flutter/material.dart';

final tabs = [
  {'icon': Icons.home, 'title': 'Home'},
  {'icon': Icons.alarm, 'title': 'Alarm'},
  {'icon': Icons.shopping_basket, 'title': 'Cart'},
  {'icon': Icons.show_chart, 'title': 'Chart'},
  {'icon': Icons.supervised_user_circle, 'title': 'User'},
];

final tabViews = [
  new FirstTabView(
    title: "First Tab View",
  ),
  new FirstTabView(
    title: "Second Tab View",
  ),
  new FirstTabView(
    title: "Third Tab View",
  ),
  new FirstTabView(
    title: "Fourth Tab View",
  ),
  new FirstTabView(
    title: "Fifth Tab View",
  ),
];

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var activeIndex = 2;

  void changeTab(index) {
    setState(() {
      activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
            backgroundColor: Colors.white,
            appBar: new AppBar(
              title: new FlutterLogo(colors: Colors.green, size: 25.0),
              elevation: 0.0,
              centerTitle: true,
              backgroundColor: Colors.white,
              leading: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_back),
                  color: Colors.grey),
              actions: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.menu),
                  color: Colors.grey,
                )
              ],
            ),
            bottomNavigationBar: CustomTabbar(
              activeIndex: activeIndex,
              tabs: tabs,
              onChange: (index) {
                this.changeTab(index);
              },
            ),
            body: Container(
              color: Colors.transparent,
              child: CustomTabbarView(
                activeIndex: activeIndex,
                tabbarViews: tabViews,
              ),
            )),
      ],
    );
  }
}

class FirstTabView extends StatefulWidget {
  final title;
  var rKey;

  set setKey(var randKey) {
    this.rKey = randKey;
  }

  FirstTabView({this.title, this.rKey});

  @override
  _FirstTabViewState createState() => _FirstTabViewState();
}

class _FirstTabViewState extends State<FirstTabView>
    with SingleTickerProviderStateMixin {
  Animation<double> titleAnim;
  Animation<double> boxAnim;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    titleAnim = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.0,
          0.5,
          curve: Curves.ease,
        )))
      ..addListener(() {
        setState(() {});
      });
    boxAnim = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.0,
          0.7,
          curve: Curves.fastOutSlowIn,
        )))
      ..addListener(() {
        setState(() {});
      });

    animationController.forward().orCancel;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(FirstTabView oldWidget) {
    if (widget.rKey != oldWidget.rKey) {
      setState(() {
        animationController.forward(from: 0.0);
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.rKey);

    // print(percent);
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Transform(
              transform:
                  Matrix4.translationValues(titleAnim.value * 400.0, 0.0, 0.0),
              child: Container(
                alignment: Alignment(0.0, -0.40),
                height: 100.0,
                color: Colors.white,
                child: Text(
                  widget.title,
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
                ),
              ),
            ),
            Transform(
              transform:
                  Matrix4.translationValues(0.0, boxAnim.value * 300.0, 0.0),
              child: Container(
                margin: EdgeInsets.fromLTRB(25.0, 90.0, 25.0, 0.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(blurRadius: 2.0, color: Colors.grey)
                    ]),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(25.0, 25.0, 5.0, 5.0),
                          child: Text(
                            'YOU HAVE',
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(25.0, 40.0, 5.0, 25.0),
                          child: Text(
                            '206',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.bold,
                                fontSize: 40.0),
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: 60.0),
                    Container(
                      height: 60.0,
                      width: 125.0,
                      decoration: BoxDecoration(
                          color: Colors.greenAccent[100].withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Center(
                        child: Text('Buy more',
                            style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.bold,
                                color: Colors.green)),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 40.0),
        Container(
            padding: EdgeInsets.only(left: 25.0, right: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Transform(
                  transform: Matrix4.translationValues(
                      boxAnim.value * -200.0, 0.0, 0.0),
                  child: Text(
                    'MY COACHES',
                    style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0),
                  ),
                ),
                Transform(
                  transform: Matrix4.translationValues(
                      boxAnim.value * 200.0, 0.0, 0.0),
                  child: Text(
                    'VIEW PAST SESSIONS',
                    style: TextStyle(
                        color: Colors.green,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0),
                  ),
                )
              ],
            )),
        SizedBox(height: 10.0),
        GridView.count(
          crossAxisCount: 2,
          primary: false,
          crossAxisSpacing: 2.0,
          mainAxisSpacing: 4.0,
          shrinkWrap: true,
          children: <Widget>[
            Transform(
                transform:
                    Matrix4.translationValues(0.0, boxAnim.value * 300.0, 0.0),
                child: _buildCard('Amir', 'Available', 1)),
            Transform(
                transform:
                    Matrix4.translationValues(0.0, boxAnim.value * 300.0, 0.0),
                child: _buildCard('Amir', 'Away', 2)),
            Transform(
                transform:
                    Matrix4.translationValues(0.0, boxAnim.value * 300.0, 0.0),
                child: _buildCard('Amir', 'Away', 3)),
            Transform(
                transform:
                    Matrix4.translationValues(0.0, boxAnim.value * 300.0, 0.0),
                child: _buildCard('Amir', 'Available', 4)),
            Transform(
                transform:
                    Matrix4.translationValues(0.0, boxAnim.value * 300.0, 0.0),
                child: _buildCard('Amir', 'Away', 5)),
            Transform(
                transform:
                    Matrix4.translationValues(0.0, boxAnim.value * 300.0, 0.0),
                child: _buildCard('Amir', 'Available', 6)),
          ],
        )
      ],
    );
  }

  Widget _buildCard(String name, String status, int cardIndex) {
    return Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 7.0,
        child: Column(
          children: <Widget>[
            SizedBox(height: 12.0),
            Stack(children: <Widget>[
              Container(
                height: 60.0,
                width: 60.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.green,
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://avatars0.githubusercontent.com/u/20580199?s=460&v=4'))),
              ),
              Container(
                margin: EdgeInsets.only(left: 40.0),
                height: 20.0,
                width: 20.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: status == 'Away' ? Colors.amber : Colors.green,
                    border: Border.all(
                        color: Colors.white,
                        style: BorderStyle.solid,
                        width: 2.0)),
              )
            ]),
            SizedBox(height: 8.0),
            Text(
              name,
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              status,
              style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: Colors.grey),
            ),
            SizedBox(height: 15.0),
            Expanded(
                child: Container(
                    width: 175.0,
                    decoration: BoxDecoration(
                      color: status == 'Away' ? Colors.grey : Colors.green,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0)),
                    ),
                    child: Center(
                      child: Text(
                        'Request',
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'Quicksand'),
                      ),
                    )))
          ],
        ),
        margin: cardIndex.isEven
            ? EdgeInsets.fromLTRB(10.0, 0.0, 25.0, 10.0)
            : EdgeInsets.fromLTRB(25.0, 0.0, 5.0, 10.0));
  }
}

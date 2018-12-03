import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class CustomTabbar extends StatefulWidget {
  final buttonWidth = 50.0;
  final activeIndex;
  final tabs;
  final void Function(int) onChange;

  CustomTabbar({this.activeIndex, this.tabs, this.onChange});
  @override
  _CustomTabbarState createState() => _CustomTabbarState();
}

class _CustomTabbarState extends State<CustomTabbar>
    with TickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  double middlePoint;
  List<Widget> tabList = new List<Widget>();
  int activeIndex;
  double slidePoint = 0.0;

  initState() {
    super.initState();
    setState(() {
      activeIndex = widget.activeIndex;
    });
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut)
      ..addListener(() {
        setState(() {
          activeIndex = widget.activeIndex;
        });
      });
    controller.forward();

    // for (var i = 0; i < widget.tabs.length; i++) {
    //   tabList.add(new CustomTab(
    //     index: i,
    //     onTap: (i) {
    //       startAnimate(i);
    //     },
    //     isActive: activeIndex == i,
    //     animation: animation.value,
    //     icon: widget.tabs[i]['icon'],
    //   ));
    // }
    tabList = [
      new CustomTab(
        index: 0,
        onTap: (i) {
          startAnimate(i);
        },
        isActive: activeIndex == 0,
        animation: animation.value,
        icon: widget.tabs[0]['icon'],
      ),
      new CustomTab(
        index: 1,
        onTap: (i) {
          startAnimate(i);
        },
        isActive: activeIndex == 1,
        animation: animation.value,
        icon: widget.tabs[1]['icon'],
      ),
      new CustomTab(
        index: 2,
        onTap: (i) {
          startAnimate(i);
        },
        isActive: activeIndex == 2,
        animation: animation.value,
        icon: widget.tabs[2]['icon'],
      ),
      new CustomTab(
        index: 3,
        onTap: (i) {
          startAnimate(i);
        },
        isActive: activeIndex == 3,
        animation: animation.value,
        icon: widget.tabs[3]['icon'],
      ),
      new CustomTab(
        index: 4,
        onTap: (i) {
          startAnimate(i);
        },
        isActive: activeIndex == 4,
        animation: animation.value,
        icon: widget.tabs[4]['icon'],
      ),
    ];
  }

  startAnimate(index) {
    double oldMiddlePoint = middlePoint;

    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut)
      ..addListener(() {
        setState(() {
          widget.onChange(index);
          activeIndex = index;
          slidePoint = lerpDouble(oldMiddlePoint, middlePoint, animation.value);
        });
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    int tabCount = 5;
    double tabSize = (MediaQuery.of(context).size.width - 10.0) / tabCount;
    middlePoint = activeIndex * tabSize + tabSize / 2;
    slidePoint = slidePoint == 0.0 ? middlePoint : slidePoint;
    double btnRadius = widget.buttonWidth / 2 + 10.0;

    var hero = new Hero(
      tag: 'hero-tag-$activeIndex',
      child: Icon(
        widget.tabs[activeIndex]['icon'],
        color: Colors.white,
      ),
    );

    return Stack(
      children: <Widget>[
        new Container(
          padding: EdgeInsets.only(top: 12.0),
          margin: EdgeInsets.only(bottom: 5.0, right: 5.0, left: 5.0),
          height: 80.0,
          child: ClipPath(
            clipper: TabbarClipper(
                slidePoint: slidePoint,
                btnRadius: btnRadius,
                activeIndex: activeIndex),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    new CustomTab(
                      index: 0,
                      onTap: (i) {
                        startAnimate(i);
                      },
                      isActive: activeIndex == 0,
                      animation: animation.value,
                      icon: widget.tabs[0]['icon'],
                    ),
                    new CustomTab(
                      index: 1,
                      onTap: (i) {
                        startAnimate(i);
                      },
                      isActive: activeIndex == 1,
                      animation: animation.value,
                      icon: widget.tabs[1]['icon'],
                    ),
                    new CustomTab(
                      index: 2,
                      onTap: (i) {
                        startAnimate(i);
                      },
                      isActive: activeIndex == 2,
                      animation: animation.value,
                      icon: widget.tabs[2]['icon'],
                    ),
                    new CustomTab(
                      index: 3,
                      onTap: (i) {
                        startAnimate(i);
                      },
                      isActive: activeIndex == 3,
                      animation: animation.value,
                      icon: widget.tabs[3]['icon'],
                    ),
                    new CustomTab(
                      index: 4,
                      onTap: (i) {
                        startAnimate(i);
                      },
                      isActive: activeIndex == 4,
                      animation: animation.value,
                      icon: widget.tabs[4]['icon'],
                    ),
                  ]),
            ),
          ),
        ),
        new Positioned(
          left: slidePoint - btnRadius + 12.0,
          top: 0.0,
          child: FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: () {
              setState(() {});
            },
            tooltip: 'Increment',
            child: Opacity(
              opacity: animation.value,
              child: hero,
            ),
            elevation: 2.0,
          ),
        )
      ],
    );
  }
}

class CustomTab extends StatelessWidget {
  final icon;
  final bool isActive;
  final void Function(int) onTap;
  final int index;
  final double animation;

  CustomTab({this.icon, this.isActive, this.index, this.onTap, this.animation});

  @override
  Widget build(BuildContext context) {
    var hero = new Hero(
      tag: 'hero-tag-$index',
      child: Icon(icon),
    );
    return InkWell(
      onTap: () {
        this.onTap(index);
      },
      child: Transform(
        transform: Matrix4.identity()
          ..rotateY(isActive ? animation * 3.141 * 2 : 0.0),
        child: Opacity(
          opacity: isActive ? 1.0 - animation : 1.0,
          child: hero,
        ),
      ),
    );
  }
}

class TabbarClipper extends CustomClipper<Path> {
  final slidePoint;
  final activeIndex;
  final btnRadius;

  TabbarClipper({this.activeIndex, this.btnRadius, this.slidePoint});

  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);

    path.lineTo(slidePoint + btnRadius, 0.0);

    path.addArc(
        new Rect.fromCircle(
            center: new Offset(slidePoint, 15.0), radius: btnRadius),
        90,
        270);

    // var firstControlPoint = new Offset(middlePoint, buttonWidth);
    // var firstEndPoint = new Offset(middlePoint - btnRadius, 0.0);
    // path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
    //     firstEndPoint.dx, firstEndPoint.dy);

    // path.lineTo(0.0, 0.0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

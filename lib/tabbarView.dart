import 'dart:math';

import 'package:flutter/material.dart';

class CustomTabbarView extends StatefulWidget {
  final activeIndex;
  final tabbarViews;

  CustomTabbarView({this.activeIndex, this.tabbarViews});

  @override
  _CustomTabbarViewState createState() => _CustomTabbarViewState();
}

class _CustomTabbarViewState extends State<CustomTabbarView> {
  var tabbarView;

  @override
  void didUpdateWidget(CustomTabbarView oldWidget) {
    if (widget.activeIndex != oldWidget.activeIndex) {
      setState(() {
        tabbarView = widget.tabbarViews[widget.activeIndex];
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      tabbarView = widget.tabbarViews[widget.activeIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    var rnd = new Random();
  var next = rnd.nextDouble() * 1000000;
    tabbarView.setKey = next;
    return tabbarView;
  }
}

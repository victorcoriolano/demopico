// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:demopico/infra/ui/pages/hub_page.dart';
import 'package:demopico/ui/widgets/EFEMERO_scroll_text.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui';

import 'package:get/get.dart';

const double minHeight = 90;
const double iconStartSize = 44;
const double iconEndSize = 120;
const double iconStartMarginTop = 36;
const double iconEndMarginTop = 80;
const double iconsVerticalSpacing = 24;
const double iconsHorizontalSpacing = 16;

class HubUpperSheet extends StatefulWidget {
  const HubUpperSheet({super.key});

  @override
  State<HubUpperSheet> createState() => _HubUpperSheetState();
}

class _HubUpperSheetState extends State<HubUpperSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  //método base
  double lerp(double min, double max) =>
      lerpDouble(min, max, _controller.value)!;

  //var com estilos animados
  double get maxHeight => MediaQuery.of(context).size.height * 0.6;
  double get headerTopMargin =>
      lerp(2, 50 + MediaQuery.of(context).padding.top);
  double get headerFontSize => lerp(14, 24);
  double get itemBorderRadius => lerp(8, 24);
  double get iconLeftBorderRadius => itemBorderRadius;
  double get iconRightBorderRadius => lerp(60, 60);
  double get iconSize => lerp(iconStartSize, iconEndSize);

  double iconLeftMargin(int index) {
    return lerp(index * (iconsHorizontalSpacing + iconStartSize), 0);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Positioned(
              height: lerp(minHeight, maxHeight + 90),
              left: 0,
              right: 0,
              bottom: MediaQuery.maybeSizeOf(context)!.height / 3.3 +
                  maxHeight -
                  maxHeight * _controller.value,
              child: GestureDetector(
                onTap: _toggle,
                onVerticalDragUpdate: _handleDragUpdate,
                onVerticalDragEnd: _handleDragEnd,
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 139, 0, 0),
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(32)),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.fromLTRB(
                              10,
                              20,
                              35,
                              2,
                            ),
                            child: Stack(children: [
                              HubIcon(isVisible: _controller.value > 0.5),
                              ScrollingText(
                                  isVisible: _controller.value > 0.3,
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  text:
                                      'Lorem ipsum is a placeholder text commonly used to demonstrate the visual form'),
                              Positioned(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Divider(
                                    thickness: 2.5,
                                    indent: 120.0,
                                    endIndent: 100.0,
                                  ),
                                ),
                              )
                            ])),
                      ],
                    )),
              ));
        });
  }

  void _toggle() {
    final bool isOpen = _controller.status == AnimationStatus.completed;
    _controller.fling(velocity: isOpen ? -2 : 2);
    Get.to(
      () => HubPage(),
      transition: Transition.upToDown,
      duration: const Duration(milliseconds: 600),
      curve: Curves.fastEaseInToSlowEaseOut,
    );
    _controller.value = 0;
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _controller.value += details.primaryDelta! / maxHeight;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_controller.status == AnimationStatus.completed ||
        _controller.value >= 0.5) {
      _controller.fling(velocity: _controller.value < 0.5 ? -2 : 2);
      Get.to(
        () => HubPage(),
        transition: Transition.upToDown,
        duration: const Duration(milliseconds: 600),
        curve: Curves.fastEaseInToSlowEaseOut,
      );
    }

    final double flingVelocity =
        details.velocity.pixelsPerSecond.dx / maxHeight;

    if (flingVelocity < 0.0) {
      _controller.fling(velocity: math.max(2, -flingVelocity));
    } else if (flingVelocity > 0) {
      _controller.fling(velocity: math.min(-2, -flingVelocity));
    } else {
      _controller.fling(velocity: _controller.value < 0.5 ? -2 : 2);
    }
    _controller.value = 0;
  }
}

class HubIcon extends StatelessWidget {
  final bool isVisible;
  const HubIcon({super.key, required this.isVisible});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: AnimatedOpacity(
        curve: Curves.bounceInOut,
        opacity: isVisible ? 1 : 0,
        duration: const Duration(milliseconds: 100),
        child: Icon(Icons.bubble_chart, size: 300, color: Colors.white),
      ),
    );
  }
}

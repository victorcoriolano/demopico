// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui';

const double minHeigth = 110;
const double iconStartSize = 40;
const double iconEndSize = 120;
const double iconStartMarginTop = 36;
const double iconEndMarginTop = 110;
const double iconsVerticalSpacing = 24;
const double iconsHorizontalSpacing = 16;

class EventsBottomSheet extends StatefulWidget {
  const EventsBottomSheet({super.key});

  @override
  State<EventsBottomSheet> createState() => _EventsBottomSheetState();
}

class _EventsBottomSheetState extends State<EventsBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  //método base
  double lerp(double min, double max) =>
      lerpDouble(min, max, _controller.value)!;

  //var com estilos animados
  double get maxHeight => MediaQuery.of(context).size.height;
  double get headerTopMargin =>
      lerp(20, 50 + MediaQuery.of(context).padding.top);
  double get headerFontSize => lerp(14, 24);
  double get itemBorderRadius => lerp(8, 24);
  double get iconLeftBorderRadius => itemBorderRadius;
  double get iconRightBorderRadius => lerp(8, 24);
  double get iconSize => lerp(iconStartSize, iconEndSize);

  double iconTopMargin(int index) {
    return lerp(iconStartMarginTop,
            iconEndMarginTop + index * (iconsVerticalSpacing + iconEndSize)) +
        headerTopMargin;
  }

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
              height: lerp(minHeigth - 30, maxHeight),
              left: 0,
              right: 0,
              bottom: 0,
              child: GestureDetector(
                onVerticalDragUpdate: _handleDragUpdate,
                onVerticalDragEnd: _handleDragEnd,
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 139, 0, 0),
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(32)),
                    ),
                    child: Stack(
                      children: <Widget>[
                        SheetHeader(
                          fontSize: headerFontSize,
                          topMargin: headerTopMargin,
                        ),
                        for (Event event in events) _buildFullItem(event),
                        for (Event event in events) _buildIcon(event),
                      ],
                    )),
              ));
        });
  }

  Widget _buildIcon(Event event) {
    int index = events.indexOf(event);
    return Positioned(
        height: iconSize,
        width: iconSize,
        top: iconTopMargin(index),
        left: iconLeftMargin(index),
        child: ClipRRect(
            borderRadius: BorderRadius.horizontal(
                left: Radius.circular(iconLeftBorderRadius),
                right: Radius.circular(iconRightBorderRadius)),
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  color: Colors.transparent,
                  child: Icon(
                    Icons.skateboarding_outlined,
                    color: Colors.white,
                    size: iconSize,
                  ),
                ))));
  }

  Widget _buildFullItem(Event event) {
    int index = events.indexOf(event);
    return ExpandedEventItem(
      topMargin: iconTopMargin(index),
      leftMargin: iconLeftMargin(index),
      height: iconSize,
      isVisible: _controller.status == AnimationStatus.completed,
      borderRadius: itemBorderRadius,
      title: event.title,
      date: event.date,
      hasLocation: event.hasLocation,
    );
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _controller.value -= details.primaryDelta! / maxHeight;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_controller.isAnimating ||
        _controller.status == AnimationStatus.completed) return;

    final double flingVelocity =
        details.velocity.pixelsPerSecond.dy / maxHeight;

    if (flingVelocity < 0.0) {
      _controller.fling(velocity: math.max(2, -flingVelocity));
    } else if (flingVelocity > 0) {
      _controller.fling(velocity: math.min(-2, -flingVelocity));
    } else {
      _controller.fling(velocity: _controller.value < 0.5 ? -2 : 2);
    }
  }
}

class Event {
  final String assetName;
  final String title;
  final String date;
  final bool hasLocation;

  Event(this.assetName, this.title, this.date, this.hasLocation);
}

class ExpandedEventItem extends StatelessWidget {
  final double topMargin;
  final double leftMargin;
  final double height;
  final bool isVisible;
  final double borderRadius;
  final String title;
  final String date;
  final bool hasLocation;
  const ExpandedEventItem(
      {super.key,
      required this.hasLocation,
      required this.topMargin,
      required this.height,
      required this.isVisible,
      required this.borderRadius,
      required this.title,
      required this.date,
      required this.leftMargin});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: topMargin,
        left: leftMargin,
        height: height,
        right: 0,
        child: AnimatedOpacity(
            opacity: isVisible ? 1 : 0,
            duration: const Duration(milliseconds: 300),
            child: Container(
              padding: EdgeInsets.only(left: height).add(EdgeInsets.all(8)),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 22, 22, 22),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: _buildContent(),
            )));
  }

  Widget _buildContent() {
    return Column(children: <Widget>[
      Text(title,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Color.fromARGB(255, 206, 206, 206))),
      SizedBox(height: 8),
      Row(
        children: [
          Text(
            'Válido até: ',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Colors.grey[600]),
          ),
          SizedBox(width: 8),
          Text(
            date,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Colors.grey[200]),
          ),
        ],
      ),
      Spacer(),
      Row(
        children: [
          Icon(Icons.place, color: Colors.grey[600], size: 16),
          Text(
            hasLocation ? 'Acessar Local' : 'Dentro do App',
            style: TextStyle(
                fontWeight: FontWeight.w200,
                fontSize: 13,
                color: Colors.grey[400]),
          ),
        ],
      )
    ]);
  }
}

final List<Event> events = [];

class SheetHeader extends StatelessWidget {
  final double fontSize;
  final double topMargin;

  const SheetHeader(
      {super.key, required this.fontSize, required this.topMargin});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topMargin,
      child: Text(
        'EVENTOS ROLANDO',
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

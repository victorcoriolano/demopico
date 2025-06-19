import 'package:flutter/material.dart';

class WeatherDialogRoute<T> extends PageRoute<T> {
  WeatherDialogRoute({required this.builder}) : super();
  final WidgetBuilder builder;

  @override
  Color? get barrierColor => Colors.black54;

  @override
  String? get barrierLabel => "Clique fora do Dialog para voltar";

  @override
  bool get barrierDismissible => true;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
        child: child);
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);
}

import 'package:flutter/material.dart';

class ProfileConfigureWidget extends StatefulWidget {
  final VoidCallback onPressed;

  const ProfileConfigureWidget({
    super.key,
    required this.onPressed,
  });

  @override
  State<ProfileConfigureWidget> createState() => _ProfileConfigureWidgetState();
}

class _ProfileConfigureWidgetState extends State<ProfileConfigureWidget> {

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        icon: const Icon(Icons.settings),
        iconSize: 30,
        color: const Color.fromARGB(255, 0, 0, 0),
        onPressed: widget.onPressed,
      ),
    );
  }
}


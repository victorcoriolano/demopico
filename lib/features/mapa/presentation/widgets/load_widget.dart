import 'package:flutter/material.dart';

class LoadWidget extends StatelessWidget {
  final Future<dynamic> future;
  final Widget newPage;
  const LoadWidget({super.key, required this.future,required this.newPage});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future, 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return newPage;
        }
      },
    );
  }
}
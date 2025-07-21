// Classe base para representar falhas
import 'package:flutter/material.dart';

abstract class Failure implements Exception {
  final String message;
  final String? code;
  final StackTrace? stackTrace;
  final Exception? originalException;

  Failure({
    required this.message,
    this.code,
    this.originalException,
    this.stackTrace,
  });

  @override
  String toString() {
    return "Failure Error: $message, code: $code, stackTrace: $stackTrace, originalException: $originalException";
  }
}



class SnackBarFailure extends SnackBar {
  final String message;
  const SnackBarFailure(
      {super.key, required this.message, required super.content});

  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 5),
      shape: const RoundedRectangleBorder(),
      elevation: 5,
    );
  }
}



import 'package:flutter/material.dart';

class User {
  final String name;
  final String? description;
  final Image? image;
  final int id;

  User({required this.name, 
  required this.description, 
  required this.image, 
  required this.id});
}
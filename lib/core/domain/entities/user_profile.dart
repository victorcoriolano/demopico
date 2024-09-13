import 'package:demopico/features/login/domain/entities/user.dart';
import 'package:flutter/material.dart';

class LoggedUser extends User {
  final String name;
  final String? description;
  final Image? image;

  LoggedUser({
    required this.name,
    required this.description,
    required this.image,
    required super.id,
    required super.vulgo,
    required super.email,
    required super.senha,
  });
}

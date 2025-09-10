import 'package:flutter/material.dart';

class GetRelationshipUc {

  final NetworkingRepository _networkingRepository;

  static GetRelationshipUc? _instance;
  GetRelationshipUc get instance => _instance ??= GetRelationshipUc({required NetworkingRepository networkingRepository}) : _networkingRepository = networkingRepository;


}
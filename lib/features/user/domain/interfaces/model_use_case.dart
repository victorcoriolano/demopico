import 'package:dartz/dartz.dart';

abstract class UseCase<Type, Params>{
  Future<Either> call(Params params);
}
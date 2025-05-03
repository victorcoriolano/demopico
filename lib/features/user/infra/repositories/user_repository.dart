import 'package:demopico/features/user/domain/models/user.dart';
import 'package:flutter/foundation.dart';

class UserRepository {
  final Set<UserM?> userList = {};

  Future<Set<UserM?>> getUserList() async {
    return userList;
  }

  UserM? getUser(String id) {
    try {
      UserM? user = userList.firstWhere((element) => element?.id == id);
      return user ?? UserM();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return UserM();
    }
  }

  Future<void> addUser(UserM user) async {
    userList.add(user);
  }

  Future<void> updateUser(UserM user) async {
    userList.removeWhere((element) => element?.id == user.id);
    userList.add(user);
  }

  Future<void> deleteUser(UserM user) async {
    userList.removeWhere((element) => element?.id == user.id);
  }
}

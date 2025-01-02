import 'dart:math';

import 'package:riverpod_app/feature1/data/datasource/LoginDataSource.dart';

class LoginLocalDataSource implements LoginDataSource {

  @override
  Future<bool> login() async {
    await Future.delayed(Duration(seconds: 2));
    return Future.value(Random().nextBool());
  }

  @override
  Future<bool> logout() async {
    await Future.delayed(Duration(seconds: 2));
    return Future.value(Random().nextBool());
  }
}
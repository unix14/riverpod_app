import 'dart:math';

import 'login_data_source.dart';

class LoginRemoteDataSource implements LoginDataSource {

  @override
  Future<bool> login() async {
    await Future.delayed(Duration(seconds: 2));
    return true;
    // return Future.value(Random().nextBool());
  }

  @override
  Future<bool> logout() async {
    await Future.delayed(Duration(seconds: 2));
    return true;
    return Future.value(Random().nextBool());
  }
}
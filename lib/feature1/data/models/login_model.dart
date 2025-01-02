import 'package:riverpod_app/feature1/domain/entities/login_user.dart';

class LoginModel{
  final String email;
  final String password;

  LoginModel({required this.email,required this.password});

  factory LoginModel.fromEntity(LoginUser loginUser) =>
    LoginModel(
      email: loginUser.email,
      password: loginUser.password,
    );

  LoginUser toEntity() => LoginUser(email: email, password: password);
}
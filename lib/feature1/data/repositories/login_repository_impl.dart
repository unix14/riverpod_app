import '../../domain/repositories/login_repository.dart';
import '../datasource/LoginDataSource.dart';

class LoginRepositoryImpl implements LoginRepository {

  final LoginDataSource loginDataSource;

  LoginRepositoryImpl({required this.loginDataSource});

  @override
  Future<bool> login(String email, String password) {
    return loginDataSource.login();
  }

  @override
  Future<bool> logout() {
    return loginDataSource.logout();
  }

}
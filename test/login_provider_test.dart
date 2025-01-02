import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/core/router/navigation_manager.dart';
import 'package:riverpod_app/feature1/data/datasource/login_remote_datasource.dart';
import 'package:riverpod_app/feature1/data/repositories/login_repository_impl.dart';
import 'package:riverpod_app/feature1/domain/repositories/login_repository.dart';
import 'package:riverpod_app/feature1/domain/usecases/login.dart';
import 'package:riverpod_app/feature1/domain/usecases/logout.dart';
import 'package:riverpod_app/feature1/presentation/providers/login_provider.dart';
import 'package:flutter_test/flutter_test.dart';


class MockLoginUseCase extends LoginUseCase {
  MockLoginUseCase(super.loginRepository);

  @override
  Future<bool> call({String email = '', String password = ''}) async {
    return true;
  }
}

class MockLogoutUseCase implements LogoutUseCase {
  MockLogoutUseCase();

  @override
  Future<bool> call() {
    // TODO: implement call
    throw UnimplementedError();
  }

  @override
  // TODO: implement loginRepository
  LoginRepository get loginRepository => throw UnimplementedError();

}

void main() {



  test('test...', (){

    LoginUseCase login = MockLoginUseCase(LoginRepositoryImpl(loginDataSource: LoginRemoteDataSource()));
    LogoutUseCase logout = LogoutUseCase(LoginRepositoryImpl(loginDataSource: LoginRemoteDataSource()));
    NavigationManager navigationManager = NavigationManager();

    final LoginNotifier loginNotifier = LoginNotifier(
      login, logout, navigationManager
    );

    loginNotifier.performLogin('email', 'password');
    loginNotifier.stream.listen((state) {
      expect(state, LoginState.loggedIn);
    });


  });
 }
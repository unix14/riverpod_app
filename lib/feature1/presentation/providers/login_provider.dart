import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/router/navigation_manager.dart';
import '../../data/datasource/LoginDataSource.dart';
import '../../domain/usecases/logout.dart';
import '../../data/datasource/login_remote_datasource.dart';
import '../../data/repositories/login_repository_impl.dart';
import '../../domain/repositories/login_repository.dart';
import '../../domain/usecases/login.dart';

final loginDataSourceProvider = Provider<LoginDataSource>((ref) {
  return LoginRemoteDataSource();
});

final loginRepositoryProvider = Provider<LoginRepository>((ref) {
  return LoginRepositoryImpl(
      loginDataSource: ref.read(loginDataSourceProvider));
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repository = ref.read(loginRepositoryProvider);
  return LoginUseCase(repository);
});

final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  final repository = ref.read(loginRepositoryProvider);
  return LogoutUseCase(repository);
});

final loginNotifierProvider = StateNotifierProvider.autoDispose<LoginNotifier, LoginState>((ref) {
  final loginUseCase = ref.read(loginUseCaseProvider);
  final logoutUseCase = ref.read(logoutUseCaseProvider);
  final navigationManager = ref.read(navigationManagerProvider);
  return LoginNotifier(loginUseCase, logoutUseCase, navigationManager);
});

enum LoginState {
  loggedIn,
  loggedOut,
  loading
}

// class LoginNotifierController extends AsyncNotifier<LoginState> {
//   @override
//   FutureOr<LoginState> build() {
//
//     // ref.listen(loginNotifierProvider, (previous, next) {});
//     // TODO: implement build
//     throw UnimplementedError();
//   }
//
// }


class LoginNotifier extends StateNotifier<LoginState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final NavigationManager navigationManager;

  LoginNotifier(this.loginUseCase, this.logoutUseCase, this.navigationManager) : super(LoginState.loggedOut);

  Future<void> performLogin(String email, String password) async {
    state = LoginState.loading;
    bool isLoggedIn = await loginUseCase.call(email: email, password: password);
    state = isLoggedIn ? LoginState.loggedIn : LoginState.loggedOut;
  }

  Future<void> performLogout() async {
    state = LoginState.loading;
    bool isLoggedOut = await logoutUseCase.call();
    state = isLoggedOut ? LoginState.loggedOut : LoginState.loggedIn;
  }

  goToLoginScreen() async {
    navigationManager.goToLoginScreen();
  }

  goToLogoutScreen() async {
    navigationManager.goToLogoutScreen();
  }

  goToProductsScreen() async {
    navigationManager.goToProductsScreen();
  }

  goToPageX() async {
    navigationManager.goToPageX();
  }
}
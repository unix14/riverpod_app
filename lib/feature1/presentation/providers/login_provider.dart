import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/service_locator.dart';
import '../../../core/router/navigation_manager.dart';


enum LoginState {
  loggedIn,
  loggedOut,
  loading
}

class LoginNotifierController extends AutoDisposeAsyncNotifier<LoginState> {
  @override
  FutureOr<LoginState> build() async {

    final logoutUseCase = ref.read(logoutUseCaseProvider);
    final isLoggedOut = await logoutUseCase.call();
    if (isLoggedOut) {
      state = AsyncValue.data(LoginState.loggedOut);
      return LoginState.loggedOut;
    } else {

      state = AsyncValue.data(LoginState.loggedIn);
      return LoginState.loggedIn;
    }
  }

  Future<void> performLogin(String email, String password) async {
    state = AsyncValue.data(LoginState.loading);
    //Validation
    if(email.isEmpty || password.isEmpty) {
      state = AsyncValue.error(LoginState.loggedOut, StackTrace.fromString("Empty fields Error message"));
      return;
    }
    final loginUseCase = ref.read(loginUseCaseProvider);
    bool isLoggedIn = await loginUseCase.call(email: email, password: password);
    state = AsyncValue.data(isLoggedIn ? LoginState.loggedIn : LoginState.loggedOut);
  }

  Future<void> performLogout() async {
    state = AsyncValue.data(LoginState.loading);
    final logoutUseCase = ref.read(logoutUseCaseProvider);
    bool isLoggedOut = await logoutUseCase.call();
    state = AsyncValue.data(isLoggedOut ? LoginState.loggedOut : LoginState.loggedIn);
  }

  goToLoginScreen() async {
    ref.read(navigationManagerProvider).goToLoginScreen();
  }

  goToLogoutScreen() async {
    ref.read(navigationManagerProvider).goToLogoutScreen();
  }

  goToProductsScreen() async {
    ref.read(navigationManagerProvider).goToProductsScreen();
  }

  goToPageX() async {
    ref.read(navigationManagerProvider).goToPageX();
  }

}

//
// class LoginNotifier extends StateNotifier<LoginState> {
//   final LoginUseCase loginUseCase;
//   final LogoutUseCase logoutUseCase;
//   final NavigationManager navigationManager;
//
//   LoginNotifier(this.loginUseCase, this.logoutUseCase, this.navigationManager) : super(LoginState.loggedOut){};
//
//   Future<void> performLogin(String email, String password) async {
//     state = LoginState.loading;
//     bool isLoggedIn = await loginUseCase.call(email: email, password: password);
//     state = isLoggedIn ? LoginState.loggedIn : LoginState.loggedOut;
//   }
//
//   Future<void> performLogout() async {
//     state = LoginState.loading;
//     bool isLoggedOut = await logoutUseCase.call();
//     state = isLoggedOut ? LoginState.loggedOut : LoginState.loggedIn;
//   }
//
//   goToLoginScreen() async {
//     navigationManager.goToLoginScreen();
//   }
//
//   goToLogoutScreen() async {
//     navigationManager.goToLogoutScreen();
//   }
//
//   goToProductsScreen() async {
//     navigationManager.goToProductsScreen();
//   }
//
//   goToPageX() async {
//     navigationManager.goToPageX();
//   }
// }
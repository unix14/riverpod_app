import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_app/core/router/route_utils.dart';


final navigationManagerProvider = Provider<NavigationManager>((ref) {
  return NavigationManager();
});

class NavigationManager{
  late final GoRouter goRouter;

  void navigateTo(String route, {Object? extra}) {
    goRouter.go(route, extra: extra);
  }

  void push(String route, {Object? extra}) {
    goRouter.push(route, extra: extra);
  }

  void replaceWith(String route, {Object? extra}) {
    goRouter.replace(route, extra: extra);
  }

  void goBack() {
    goRouter.pop();
  }

  /// Decoupled navigation
  goToLogoutScreen() => push(AppPages.logout.routePath);
  goToLoginScreen() => push(AppPages.login.routePath);
  goToProductsScreen() => push(AppPages.pagex.routePath);
  goToPageX() {
    push(AppPages.products.routePath);
    push(AppPages.pagex.routePath);
  }
}
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

  bool goBack() {
    if(!goRouter.canPop()){
      return false;
    }
    goRouter.pop();
    return true;
  }

  bool isCurrentRoute(String route) {
    // RouteBase rb = goRouter.configuration.routes.last;

    return goRouter.state?.name == route;
  }

  /// Decoupled navigation
  goToLogoutScreen() => push(AppPages.logout.routePath);
  goToLoginScreen() => _clearAndNavigate(AppPages.login.routePath);

  goToProductsScreen() => push(AppPages.products.routePath);
  goToPageX() {
    goRouter.push(AppPages.products.routePath);
    goRouter.push(AppPages.pagex.routePath);
  }

  goToNextBusinessScreen() => push(AppPages.businessNext.routePath);
  goToNextOrdersScreen() => push(AppPages.ordersNext.routePath);
  goToNextCartScreen() => push(AppPages.cartNext.routePath);

  _clearAndNavigate(String path) {
    while (goRouter.canPop() == true) {
      goRouter.pop();
    }
    goRouter.pushReplacement(path);
  }
}
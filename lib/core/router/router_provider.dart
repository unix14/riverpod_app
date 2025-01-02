import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/core/router/navigation_manager.dart';
import 'package:riverpod_app/core/router/route_utils.dart';
import 'package:riverpod_app/feature2/products_screen.dart';

import '../../feature1/presentation/screens/login_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final navigationManager = ref.read(navigationManagerProvider);

  final goRouter = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: AppPages.login.routePath,
        name: AppPages.login.name,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppPages.logout.routePath,
        name: AppPages.logout.name,
        builder: (context, state) => const Text('Logout Screen'),
      ),
      GoRoute(
          path: AppPages.products.routePath,
          name: AppPages.products.name,
          pageBuilder: (context, state) => CustomTransitionPage(
              child: ProductsScreen(),
              transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child) {
                  return SlideTransition(
                      position: Tween<Offset>(
                          begin:
                          const Offset(1, 0), // Slide in from the right
                          end: Offset.zero,
                      ).animate(animation),
                      child: child,
                  );
              }),
          routes: [
            GoRoute(
                path: '/pagex',
                name: AppPages.pagex.name,
                pageBuilder: (context, state) => CustomTransitionPage(
                      child: Scaffold(
                          appBar: AppBar(title: Text('pagex')),
                          body: Center(child: Text('pagex'))),
                      transitionsBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation,
                          Widget child) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin:
                                const Offset(1, 0), // Slide in from the right
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        );
                      },
                    )
                // builder: (context, state) => Scaffold(
                //     appBar: AppBar(title: Text('pagex')),
                //     body: Center(child: Text('pagex'))),
                ),
          ]),
    ],
  );

  navigationManager.goRouter = goRouter;
  return goRouter;
});

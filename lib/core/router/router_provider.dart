import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/app_startup_widget.dart';
import 'package:riverpod_app/core/router/navigation_manager.dart';
import 'package:riverpod_app/core/router/route_utils.dart';
import 'package:riverpod_app/core/widgets/scaffold_navigation_bar.dart';
import 'package:riverpod_app/products_list/presentation/screens/products_list_screen.dart';

import '../../feature1/presentation/screens/login_screen.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHome = GlobalKey<NavigatorState>(debugLabel: 'home');
final _shellNavigatorBusiness = GlobalKey<NavigatorState>(debugLabel: 'business');
final _shellNavigatorOrders = GlobalKey<NavigatorState>(debugLabel: 'orders');
final _shellNavigatorCart = GlobalKey<NavigatorState>(debugLabel: 'cart');

final goRouterProvider = Provider<GoRouter>((ref) {
  final navigationManager = ref.read(navigationManagerProvider);

final goRouter = GoRouter(
    initialLocation: AppPages.init.routePath,
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: AppPages.init.routePath,
        name: AppPages.init.name,
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: Text('init screen app bar'),),
          body: AppStartupWidget(),
        )),
      GoRoute(
        path: AppPages.logout.routePath,
        name: AppPages.logout.name,
        builder: (context, state) =>
        Scaffold(
            appBar: AppBar(title: Text('next cart screen app bar'),),
            body: Center(child: const Text('Just a screen without the navigation bar'))),
      ),
      StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return ScaffoldNavigationBar(
               navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(navigatorKey: _shellNavigatorHome, routes: [
              GoRoute(
                  path: AppPages.login.routePath,
                  name: AppPages.login.name,
                  pageBuilder: (context, state) => NoTransitionPage(child: const LoginScreen()),
                  routes: [
                    GoRoute(
                        path: AppPages.products.routePath,
                        name: AppPages.products.name,
                        pageBuilder: (context, state) => CustomTransitionPage(
                            child: ProductsListScreen(),
                            transitionsBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation,
                                Widget child) {
                              return SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(
                                      1, 0), // Slide in from the right
                                  end: Offset.zero,
                                ).animate(animation),
                                child: child,
                              );
                            }),
                        routes: [
                          GoRoute(
                              path: '/pagex',
                              name: AppPages.pagex.name,
                              pageBuilder: (context, state) =>
                                  CustomTransitionPage(
                                    child: Scaffold(
                                        appBar: AppBar(title: Text('pagex')),
                                        body: Center(child: Text('pagex'))),
                                    transitionsBuilder: (BuildContext context,
                                        Animation<double> animation,
                                        Animation<double> secondaryAnimation,
                                        Widget child) {
                                      return SlideTransition(
                                        position: Tween<Offset>(
                                          begin: const Offset(1,
                                              0), // Slide in from the right
                                          end: Offset.zero,
                                        ).animate(animation),
                                        child: child,
                                      );
                                    },
                                  )
                              ),
                        ]),
                  ]),
            ]),
            StatefulShellBranch(
              navigatorKey: _shellNavigatorBusiness,
              routes: [
                GoRoute(
                  path: AppPages.business.routePath,
                  name: AppPages.business.name,
                  pageBuilder: (context, state) => NoTransitionPage(
                    child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'This is Business Screen',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  navigationManager.goToNextBusinessScreen();
                                },
                                child: Text('Next Screen'))
                          ],
                        )),
                  ),
                ),
                GoRoute(
                  path: AppPages.businessNext.routePath,
                  name: AppPages.businessNext.name,
                  builder: (context, state) => Scaffold(
                    appBar: AppBar(title: Text('next business screen app bar'),),
                    body: Center(
                        child: Text(
                          'This is Business Screen with next route',
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        )),
                  ),
                )
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _shellNavigatorOrders,
              routes: [
                GoRoute(
                    path: AppPages.orders.routePath,
                    name: AppPages.orders.name,
                    pageBuilder: (context, state) => NoTransitionPage(
                      child: ProductsListScreen(),
                      ),
                    ),
                GoRoute(
                  path: AppPages.ordersNext.routePath,
                  name: AppPages.ordersNext.name,
                  builder: (context, state) => Scaffold(
                    appBar: AppBar(title: Text('next order screen app bar'),),
                    body: Center(
                        child: Text(
                            'This is Orders Screen with next route')),
                  ),
                )
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _shellNavigatorCart,
              routes: [
                GoRoute(
                  path: AppPages.cart.routePath,
                  name: AppPages.cart.name,
                  pageBuilder: (context, state) => NoTransitionPage(
                    child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'This is Cart Screen',
                              style: TextStyle(
                                color: Colors.yellow,
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  navigationManager.goToLogoutScreen();
                                },
                                child: Text('Next Screen'))
                          ],
                        )),
                  ),
                ),
              ],
            ),
            StatefulShellBranch(navigatorKey: _shellNavigatorHome, routes: [
              GoRoute(
                  path: AppPages.login.routePath,
                  name: AppPages.login.name,
                  pageBuilder: (context, state) => NoTransitionPage(child: const LoginScreen()),
                  routes: [
                    GoRoute(
                        path: AppPages.products.routePath,
                        name: AppPages.products.name,
                        pageBuilder: (context, state) => CustomTransitionPage(
                            child: ProductsListScreen(),
                            transitionsBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation,
                                Widget child) {
                              return SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(
                                      1, 0), // Slide in from the right
                                  end: Offset.zero,
                                ).animate(animation),
                                child: child,
                              );
                            }),
                        routes: [
                          GoRoute(
                              path: '/pagex',
                              name: AppPages.pagex.name,
                              pageBuilder: (context, state) =>
                                  CustomTransitionPage(
                                    child: Scaffold(
                                        appBar: AppBar(title: Text('pagex')),
                                        body: Center(child: Text('pagex'))),
                                    transitionsBuilder: (BuildContext context,
                                        Animation<double> animation,
                                        Animation<double> secondaryAnimation,
                                        Widget child) {
                                      return SlideTransition(
                                        position: Tween<Offset>(
                                          begin: const Offset(1,
                                              0), // Slide in from the right
                                          end: Offset.zero,
                                        ).animate(animation),
                                        child: child,
                                      );
                                    },
                                  )
                              ),
                        ]),
                  ]),
            ]),
          ]),
    ]
    );

  navigationManager.goRouter = goRouter;
  return goRouter;
});

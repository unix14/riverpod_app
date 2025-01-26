import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/core/theme/cbc_theme.dart';

import 'core/router/router_provider.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  //initialize();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: 'Riverpod App',
      theme: CBCTheme.theme,
      routerConfig: goRouter,
    );
  }
}


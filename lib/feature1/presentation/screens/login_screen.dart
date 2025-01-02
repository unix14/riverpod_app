import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/login_provider.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentState = ref.watch(loginNotifierProvider);

    return Scaffold(
        appBar: AppBar(
          title: currentState == LoginState.loggedIn
              ? const Text('Logout State')
              : const Text('Login State'),
        ),
        body: switch (currentState) {
          LoginState.loggedIn => logoutWidget(ref),
          LoginState.loggedOut => loginWidget(ref),
          LoginState.loading => Center(child: CircularProgressIndicator()),
        });
  }

  Widget logoutWidget(ref) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () => ref
                    .read(loginNotifierProvider.notifier)
                    .performLogout(),
                child: const Text('Logout')),
            SizedBox(height: 36),
            ElevatedButton(
                onPressed: () =>
                    ref.read(loginNotifierProvider.notifier).goToProductsScreen(),
                child: const Text('Go to a different screen')),
            SizedBox(height: 36),
            ElevatedButton(
                onPressed: () =>
                    ref.read(loginNotifierProvider.notifier).goToPageX(),
                child: const Text('Jump to a PageX')),
          ],
        ),
      ),
    );
  }

  Widget loginWidget(WidgetRef ref) {
    String email = '';
    String password = '';

    return Container(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              key: Key('email'),
                onChanged: (value) {
              email = value;
            }),
            SizedBox(height: 10),
            const Text('Password'),
            SizedBox(height: 50),
            TextField(
                key: Key('password'),
                onChanged: (value) {
              password = value;
            }),
            SizedBox(height: 10),
            const Text('Email'),
            SizedBox(height: 80),
            ElevatedButton(
              key: Key('login'),
                onPressed: () => ref
                    .read(loginNotifierProvider.notifier)
                    .performLogin(email, password),
                child: const Text('Login')),
          ],
        ),
      ),
    );
  }
}

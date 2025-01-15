import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/service_locator.dart';
import '../providers/login_provider.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentState = ref.watch(loginNotifierProvider);

    // If error state occurs, show the error popup.
    if (currentState is AsyncError) {
      // Show the error dialog on top of the login screen.
      Future.delayed(Duration.zero, () async {
        await _showErrorDialog(context, currentState.error.toString());
        ref.read(loginNotifierProvider.notifier).performLogout();
      });
    }

    return Scaffold(
        appBar: AppBar(
          title:
            currentState.when(
                data: (data) => Text(data == LoginState.loggedIn ? 'Logout State' : 'Login State'),
                error: (error, _) => Text(error.toString()),
                loading: () => const CircularProgressIndicator()),
        ),
        body: switch (currentState.value ?? LoginState.loggedOut) {
          LoginState.loggedIn => logoutWidget(ref),
          LoginState.loggedOut => loginWidget(ref),
          LoginState.loading => Center(child: CircularProgressIndicator()),
        });
  }

  // Method to show an error dialog
  Future<void> _showErrorDialog(BuildContext context, String errorMessage) async {
    await showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing dialog without action
      builder: (BuildContext context) {
        return AlertDialog(
          key: Key("error"),
          title: const Text("Error"),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget logoutWidget(ref) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          children: [
            ElevatedButton(
                key: Key('logout'),
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

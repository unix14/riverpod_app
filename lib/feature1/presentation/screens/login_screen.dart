import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/service_locator.dart';
import '../../../core/translations/translations_consts.dart';
import '../../../core/translations/translations_manager.dart';
import '../providers/login_provider.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final currentState = ref.watch(loginNotifierProvider);
    TranslationsManager tm = ref.watch(translationsManagerProvider).requireValue;

    // example of usage:
    // LoginNotifierController controller = ref.read(loginNotifierProvider.notifier);
    // controller.goToPageX();

    // If error state occurs, show the error popup.
    if (currentState is AsyncError) {
      // Show the error dialog on top of the login screen.
      Future.delayed(Duration.zero, () async {
        await _showErrorDialog(context, currentState.error.toString());
        ref.read(loginNotifierProvider.notifier).performLogout();
      });
    }

    return switch (currentState.value ?? LoginState.loggedOut) {
          LoginState.loggedIn => logoutWidget(ref, tm),
          LoginState.loggedOut => loginWidget(ref, tm),
          LoginState.loading => Center(child: CircularProgressIndicator()),
        };
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

  Widget logoutWidget(WidgetRef ref, TranslationsManager tm) {
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
                child: Text(tm.get(homeScreenLogoutButton))),
            SizedBox(height: 36),
            ElevatedButton(
                onPressed: () =>
                    ref.read(loginNotifierProvider.notifier).goToProductsScreen(),
                child: Text(tm.get(homeScreenGoToDifferentScreen))),
            SizedBox(height: 36),
            ElevatedButton(
                onPressed: () =>
                    ref.read(loginNotifierProvider.notifier).goToPageX(),
                child :Text(tm.get(homeScreenJumpToPageX))),
            SizedBox(height: 36),
            ElevatedButton(
                onPressed: () =>
                    ref.read(loginNotifierProvider.notifier).changeLanguage(),
                child :Text(tm.get(homeScreenChangeLanguage))),
          ],
        ),
      ),
    );
  }

  Widget loginWidget(WidgetRef ref, TranslationsManager tm) {
    String email = '';
    String password = '';

    return Container(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              key: Key('email'),
                onChanged: (value) {
              email = value;
            }),
            SizedBox(height: 10),
            Text(tm.get('סיסמה')),
            SizedBox(height: 50),
            TextField(
                key: Key('password'),
                onChanged: (value) {
              password = value;
            }),
            SizedBox(height: 10),
            Text(tm.get(generalEmail)),
            SizedBox(height: 80),
            Center(
              child: ElevatedButton(
                key: Key('login'),
                  onPressed: () => ref
                      .read(loginNotifierProvider.notifier)
                      .performLogin(email, password),
                  child: Text(tm.get(homeScreenLoginButton))),
            ),
          ],
        ),
      ),
    );
  }
}

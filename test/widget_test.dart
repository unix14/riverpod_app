// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_app/core/providers/service_locator.dart';
import 'package:riverpod_app/core/router/navigation_manager.dart';
import 'package:riverpod_app/feature1/data/datasource/login_remote_datasource.dart';
import 'package:riverpod_app/feature1/data/repositories/login_repository_impl.dart';
import 'package:riverpod_app/feature1/domain/usecases/login.dart';
import 'package:riverpod_app/feature1/domain/usecases/logout.dart';
import 'package:riverpod_app/feature1/presentation/providers/login_provider.dart';
import 'package:riverpod_app/feature1/presentation/screens/login_screen.dart';

import 'package:riverpod_app/main.dart';

void main() {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(const MyApp());
  //
  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);
  //
  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();
  //
  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });

  testWidgets('demo widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    //Arrange
    final email = find.byKey(ValueKey('email'));
    final password = find.byKey(ValueKey('password'));
    final addButton = find.byKey(ValueKey('login'));

    LoginNotifierController mockLoginNotifierController = MockLoginNotifier();

    //Act

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          loginNotifierProvider.overrideWith(() => MockLoginNotifier()),
        ],
        child: const MaterialApp(
          home: LoginScreen(),
        ),
      ),
    );


    await tester.enterText(email, 'test@email.com');
    await tester.enterText(password, 'password.test');
    // await tester.tap(addButton);
    await tester.pump();

    //Assert
    expect(find.text('password.test'), findsOneWidget);
    expect(find.text('test@email.com'), findsOneWidget);
    // expect(find.text('Logout'), findsOneWidget);
  });
}

class MockLoginNotifier extends LoginNotifierController {
  MockLoginNotifier();
}

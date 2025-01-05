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
import 'package:riverpod_app/feature1/presentation/providers/login_provider.dart';
import 'package:riverpod_app/feature1/presentation/screens/login_screen.dart';

void main() {

  testWidgets('demo widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    //Arrange
    final email = find.byKey(ValueKey('email'));
    final password = find.byKey(ValueKey('password'));

    LoginNotifierController mockLoginNotifierController = MockLoginNotifier();

    //Act
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          loginNotifierProvider.overrideWith(() => mockLoginNotifierController),
        ],
        child: const MaterialApp(
          home: LoginScreen(),
        ),
      ),
    );


    await tester.enterText(email, 'test@email.com');
    await tester.enterText(password, 'password.test');
    await tester.pump();

    //Assert
    expect(find.text('password.test'), findsOneWidget);
    expect(find.text('test@email.com'), findsOneWidget);
  });


  /// Test to see if clicking on login button changes the screen and now we have a logout button
  testWidgets('demo widget test 2', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    //Arrange
    final email = find.byKey(ValueKey('email'));
    final password = find.byKey(ValueKey('password'));
    final actionButton = find.byKey(ValueKey('login'));
    LoginNotifierController mockLoginNotifierController = MockLoginNotifier();

    //Act
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          loginNotifierProvider.overrideWith(() => mockLoginNotifierController),
        ],
        child: const MaterialApp(
          home: LoginScreen(),
        ),
      ),
    );


    await tester.enterText(email, 'test@email.com');
    await tester.enterText(password, 'password.test');
    await tester.tap(actionButton);
    await tester.pump();

    // Wait for 2 seconds
    await tester.pump(Duration(seconds: 2));

    //Assert
    expect(find.byKey(ValueKey('logout')), findsOneWidget);
  });
}

class MockLoginNotifier extends LoginNotifierController {
  MockLoginNotifier();
}

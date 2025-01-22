import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/core/providers/service_locator.dart';
import 'package:riverpod_app/feature1/data/datasource/login_remote_datasource.dart';
import 'package:riverpod_app/feature1/presentation/providers/login_provider.dart';
import 'package:flutter_test/flutter_test.dart';


class MockLoginDataSource extends LoginRemoteDataSource {
  @override
  Future<bool> login() async {
    return await Future.value(true);
  }

  @override
  Future<bool> logout() async {
    return await Future.value(true);
  }
}

void main() {

  // Test login state
  test('test login state', () {
    /// Arrange
    var overrides =  [loginDataSourceProvider.overrideWith((ref){
      return MockLoginDataSource();
    })];

    final container = createContainer(overrides: overrides);

    final controller =  container.read(loginNotifierProvider.notifier);

    ///Act
    controller.performLogin('email', 'password').then((_){
         ///assert
         expect(container.read(loginNotifierProvider).value,LoginState.loggedIn);
        }
    );
  });
}


ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  final container = ProviderContainer(
    parent: parent,
    overrides: overrides,
    observers: observers,
  );
  addTearDown(container.dispose);
  return container;
}
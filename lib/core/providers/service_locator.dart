import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../feature1/data/datasource/LoginDataSource.dart';
import '../../feature1/data/datasource/login_remote_datasource.dart';
import '../../feature1/data/repositories/login_repository_impl.dart';
import '../../feature1/domain/repositories/login_repository.dart';
import '../../feature1/domain/usecases/login.dart';
import '../../feature1/domain/usecases/logout.dart';
import '../../feature1/presentation/providers/login_provider.dart';


//***** login providers *****//

final loginDataSourceProvider = Provider<LoginDataSource>((ref) {
  return LoginRemoteDataSource();
});

final loginRepositoryProvider = Provider<LoginRepository>((ref) {
  return LoginRepositoryImpl(
      loginDataSource: ref.read(loginDataSourceProvider));
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repository = ref.read(loginRepositoryProvider);
  return LoginUseCase(repository);
});

final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  final repository = ref.read(loginRepositoryProvider);
  return LogoutUseCase(repository);
});

final loginNotifierProvider = AutoDisposeAsyncNotifierProvider<LoginNotifierController, LoginState>(
  () => LoginNotifierController(),
);

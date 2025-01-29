import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../feature1/data/datasource/login_data_source.dart';
import '../../feature1/data/datasource/login_remote_datasource.dart';
import '../../feature1/data/repositories/login_repository_impl.dart';
import '../../feature1/domain/repositories/login_repository.dart';
import '../../feature1/domain/usecases/login.dart';
import '../../feature1/domain/usecases/logout.dart';
import '../../feature1/presentation/providers/login_provider.dart';

import '../db/storage_manager.dart';
import '../logger/logger.dart';
import '../translations/translations_manager.dart';

//***** Startup provider *****//
final appStartupProvider = FutureProvider<bool>((ref) async {
  ref.onDispose((){
    ref.invalidate(storageManagerProvider);
    ref.invalidate(translationsManagerProvider);
  });
  // initialize the providers by awaiting its .future
  await ref.watch(storageManagerProvider.future);
  await ref.watch(translationsManagerProvider.future);
  return true;
});

//***** Storage provider *****//
final storageManagerProvider = FutureProvider<StorageManager>((ref) async {
  return await StorageManager().init();
});

///***** Translations Provider *****//
final translationsManagerProvider = FutureProvider<TranslationsManager>((ref) async {
  TranslationsManager tm = TranslationsManager();
  // await tm.init();
  return tm;
});

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

//network Provider


//***** logger provider *****//
final loggerProvider = Provider<Logger>((ref) {
  return Logger();
});



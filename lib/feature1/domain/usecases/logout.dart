import '../repositories/login_repository.dart';

class LogoutUseCase {
  final LoginRepository loginRepository;

  LogoutUseCase(this.loginRepository);

  Future<bool> call() async {
    return await loginRepository.logout();
  }
}
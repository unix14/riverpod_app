import '../repositories/login_repository.dart';

class LoginUseCase {

  final LoginRepository loginRepository;

  LoginUseCase(this.loginRepository);

  Future<bool> call({String email = '', String password = ''}) async {
    return await loginRepository.login(email, password);
  }
}
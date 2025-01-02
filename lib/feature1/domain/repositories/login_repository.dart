abstract class LoginRepository {
  Future<bool> login(String email, String password);
  Future<bool> logout();
}
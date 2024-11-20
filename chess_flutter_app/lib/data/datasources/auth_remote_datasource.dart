import '../../core/network/api_service.dart';

class AuthRemoteDataSource {
  final ApiService apiService;

  AuthRemoteDataSource(this.apiService);

  Future<String> login(String email, String password) async {
    final response = await apiService.post(
      '/user/sign-in',
      {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      return response.body; // Return token
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }

  Future<void> register(String email, String password) async {
    final response = await apiService.post(
      '/user/sign-up',
      {'email': email, 'password': password},
    );

    if (response.statusCode != 201) {
      throw Exception('Registration failed: ${response.body}');
    }
  }
}

import '../../core/error/failure.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<String> login(String email, String password) async {
    try {
      return await remoteDataSource.login(email, password);
    } catch (e) {
      throw ServerFailure('Login failed');
    }
  }

  @override
  Future<void> register(String email, String password) async {
    try {
      await remoteDataSource.register(email, password);
    } catch (e) {
      throw ServerFailure('Registration failed');
    }
  }
}

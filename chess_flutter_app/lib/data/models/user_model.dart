import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.name,
    required super.email,
    required super.password,
    super.score = 0,
  });

  // Deserialize JSON to UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      score: json['score'] ?? 0,
    );
  }

  // Serialize UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'score': score,
    };
  }
}

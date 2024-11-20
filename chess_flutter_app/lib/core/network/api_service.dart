import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    return http.post(uri, body: body);
  }
}

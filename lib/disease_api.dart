import 'dart:convert';
import 'package:http/http.dart' as http;

class DiseaseApi {
  final String baseUrl; // 에뮬레이터: http://10.0.2.2:8000
  DiseaseApi(this.baseUrl);

  Future<List<dynamic>> predictTopK({
    required List<String> symptoms,
    int topK = 3,
  }) async {
    final url = Uri.parse('$baseUrl/predict');

    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "symptoms": symptoms,
        "top_k": topK,
      }),
    );

    if (res.statusCode != 200) {
      throw Exception('API Error ${res.statusCode}: ${res.body}');
    }

    final decoded = jsonDecode(res.body);

    if (decoded is Map && decoded["top_k"] is List) {
      return decoded["top_k"];
    } else {
      throw Exception("Unexpected response format: ${res.body}");
    }
  }
}

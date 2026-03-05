import 'dart:convert';
import 'package:http/http.dart' as http;

class DiseaseApi {
  final String baseUrl; // 에뮬레이터: http://10.0.2.2:8000
  DiseaseApi(this.baseUrl);

  Future<List<Map<String, dynamic>>> predictTopK({
    required List<String> symptoms,
    int topK = 3,
  }) async {
    final url = Uri.parse('$baseUrl/predict');

    final res = await http
        .post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "symptoms": symptoms,
            "top_k": topK,
          }),
        )
        .timeout(const Duration(seconds: 15));

    if (res.statusCode != 200) {
      throw Exception(
        'API Error ${res.statusCode}: ${utf8.decode(res.bodyBytes)}',
      );
    }

    final decoded = jsonDecode(utf8.decode(res.bodyBytes));

    if (decoded is! Map) {
      throw Exception(
        "Unexpected response (not a JSON object): ${res.body}",
      );
    }

    final top = decoded["top_k"];
    if (top is! List) {
      throw Exception(
        "Unexpected response (top_k is not a List): ${res.body}",
      );
    }

    return top
        .map((e) => Map<String, dynamic>.from(e as Map))
        .toList();
  }
}

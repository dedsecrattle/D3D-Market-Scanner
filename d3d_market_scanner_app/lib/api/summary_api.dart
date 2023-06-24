import 'dart:convert';
import 'package:http/http.dart' as http;

class SummaryApi {
  static Future<List<dynamic>> fetchSummary() async {
    var response = await http
        .get(Uri.parse("https://d3d-financial-data-api.onrender.com/cot-data"));
    return jsonDecode(response.body);
  }
}

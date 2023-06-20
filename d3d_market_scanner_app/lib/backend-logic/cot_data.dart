import 'package:http/http.dart' as http;

Future<String> cot() async {
  final url = Uri.https('d3d-financial-data-api.onrender.com', 'cot-data');
  final response = await http.get(url);
  return response.body;
}

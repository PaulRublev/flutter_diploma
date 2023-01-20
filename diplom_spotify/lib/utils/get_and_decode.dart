import 'dart:convert';
import 'package:http/http.dart' as http;

dynamic httpGetAndDecode(Uri uri) async {
  final response = await http.get(uri);
  return json.decode(response.body);
}

import 'dart:convert';
import 'package:http/http.dart' as http;

const urlPrefix = 'https://api.napster.com';
const apiKey = 'apikey=ZThhYzkwNDItODczNC00MWZlLTgxODUtZWExNDQ2YTYyNGY0';
const artist70x47 = '70x47';
const artist150x100 = '150x100';
const artist356x237 = '356x237';
const artist633x422 = '633x422';

dynamic httpGetAndDecode(Uri uri) async {
  final response = await http.get(uri);
  return json.decode(response.body);
}

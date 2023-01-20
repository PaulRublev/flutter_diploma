import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:module_data/src/api/network_service.dart';
import 'package:module_model/module_model.dart';

class NetworkServiceImplementation implements NetworkService {
  late int _offset;

  @override
  void initialize() {
    _offset = 0;
  }

  @override
  Future<List<Artist>> getArtists(String? searchValue) async {
    const String urlTop = "https://api.napster.com/v2.2/artists/top?"
        "apikey=ZThhYzkwNDItODczNC00MWZlLTgxODUtZWExNDQ2YTYyNGY0&limit=10";
    final String urlSearch = "https://api.napster.com/v2.2/search?"
        "apikey=ZThhYzkwNDItODczNC00MWZlLTgxODUtZWExNDQ2YTYyNGY0&query="
        "$searchValue&per_type_limit=10";
    final offset = _offset == 0 ? '' : '&offset=$_offset';
    _offset += 10;
    var uri = '';
    if (searchValue != null) {
      uri = urlSearch;
    } else {
      uri = urlTop;
    }
    final url = Uri.parse('$uri$offset');
    var rawData = await _httpGetAndDecode(url) as Map<String, dynamic>;
    if (searchValue != null) {
      rawData = rawData['search']['data'] as Map<String, dynamic>;
    }
    List<dynamic> data = rawData['artists'];
    return data.map((artist) => Artist.fromJson(artist)).toList();
  }

  @override
  Future<List<Track>> getTracksTop(String artistId) async {
    final offset = _offset == 0 ? '' : '&offset=$_offset';
    _offset += 5;
    final url = Uri.parse("https://api.napster.com/v2.2/artists/$artistId"
        "/tracks/top?apikey=ZThhYzkwNDItODczNC00MWZlLTgxODUtZWExNDQ2YTYyNGY0&"
        "limit=5$offset");
    var rawData = await _httpGetAndDecode(url) as Map<String, dynamic>;
    List<dynamic> data = rawData['tracks'];
    return data.map((artist) => Track.fromJson(artist)).toList();
  }

  dynamic _httpGetAndDecode(Uri uri) async {
    final response = await http.get(uri);
    return json.decode(response.body);
  }
}

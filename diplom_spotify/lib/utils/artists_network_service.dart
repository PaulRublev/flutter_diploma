import 'package:diplom_spotify/utils/get_and_decode.dart';
import 'package:module_model/module_model.dart';

class ArtistsNetworkService {
  late int _offset;
  String? _searchValue;

  void initialize(String? searchValue) {
    _searchValue = searchValue;
    _offset = 0;
  }

  Future<List<Artist>> getArtists() async {
    const String urlTop = "https://api.napster.com/v2.2/artists/top?"
        "apikey=ZThhYzkwNDItODczNC00MWZlLTgxODUtZWExNDQ2YTYyNGY0&limit=10";
    final String urlSearch = "https://api.napster.com/v2.2/search?"
        "apikey=ZThhYzkwNDItODczNC00MWZlLTgxODUtZWExNDQ2YTYyNGY0&query="
        "$_searchValue&per_type_limit=10";
    final offset = _offset == 0 ? '' : '&offset=$_offset';
    _offset += 10;
    var uri = '';
    if (_searchValue != null) {
      uri = urlSearch;
    } else {
      uri = urlTop;
    }
    final url = Uri.parse('$uri$offset');
    var rawData = await httpGetAndDecode(url) as Map<String, dynamic>;
    if (_searchValue != null) {
      rawData = rawData['search']['data'] as Map<String, dynamic>;
    }
    List<dynamic> data = rawData['artists'];
    return data.map((artist) => Artist.fromJson(artist)).toList();
  }
}

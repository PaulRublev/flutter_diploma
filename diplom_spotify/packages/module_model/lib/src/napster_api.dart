class NapsterApi {
  static const baseUrl = 'https://api.napster.com/v2.2';
  static const token =
      'apikey=ZThhYzkwNDItODczNC00MWZlLTgxODUtZWExNDQ2YTYyNGY0';

  static Uri artistTopTracks(int offset, String artistId) {
    return Uri.parse("$baseUrl/artists/$artistId"
        "/tracks/top?$token&"
        "limit=5&offset=$offset");
  }

  static Uri artistTop(int offset) {
    return Uri.parse('$baseUrl/artists/top?$token&'
        'limit=10&offset=$offset');
  }

  static Uri artistSearch(int offset, String searchValue) {
    return Uri.parse('$baseUrl/search?$token&query='
        '$searchValue&per_type_limit=10&offset=$offset');
  }

  static Uri tracksList(String trackIdsString) {
    return Uri.parse('$baseUrl/tracks/$trackIdsString?$token');
  }
}

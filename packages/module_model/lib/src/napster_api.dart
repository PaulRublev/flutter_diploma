class NapsterApi {
  static const baseUrl = 'https://api.napster.com/v2.2';
  static const baseImageServerUrl = 'https://api.napster.com/imageserver/v2';
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

  static String album70x70ImageUrl(String albumId) {
    return "$baseImageServerUrl/albums/$albumId/images/70x70.jpg";
  }

  static String album170x170ImageUrl(String albumId) {
    return "$baseImageServerUrl/albums/$albumId/images/170x170.jpg";
  }

  static String artist150x100ImageUrl(String artistId) {
    return "$baseImageServerUrl/artists/$artistId/images/150x100.jpg";
  }

  static String artist356x237ImageUrl(String artistId) {
    return "$baseImageServerUrl/artists/$artistId/images/356x237.jpg";
  }
}

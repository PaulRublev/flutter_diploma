import 'dart:convert';
import 'package:http/http.dart' as http;

const urlPrefix = 'https://api.napster.com';
const apiKey = 'apikey=ZThhYzkwNDItODczNC00MWZlLTgxODUtZWExNDQ2YTYyNGY0';
const pathArtistsImageserver = '/imageserver/v2/artists/';
const pathAlbumsImageserver = '/imageserver/v2/albums/';
const artistsTop = '/v2.2/artists/top';
const artistsSearch = '/v2.2/search';
const searchLimit = 'per_type_$artistsLimit';
const queryText = 'query';
const searchText = 'search';
const dataText = 'data';
const artistsLimit = 'limit=10';
const textArtists = 'artists';
const pathImage = '/images/';
const extension = '.jpg';
const artist70x47 = '70x47';
const artist150x100 = '150x100';
const artist356x237 = '356x237';
const artist633x422 = '633x422';
const artists = '/v2.2/artists/';
const tracksTop = '/tracks/top';
const tracksLimit = 'limit=5';
const textTracks = 'tracks';
const album70x70 = '70x70';
const album170x170 = '170x170';
const album200x200 = '200x200';
const album300x300 = '300x300';
const album500x500 = '500x500';

dynamic httpGetAndDecode(Uri uri) async {
  final response = await http.get(uri);
  return json.decode(response.body);
}

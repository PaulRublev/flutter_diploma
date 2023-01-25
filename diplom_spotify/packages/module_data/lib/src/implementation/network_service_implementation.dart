import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:module_data/src/api/network_service.dart';
import 'package:module_model/module_model.dart';

class NetworkServiceImplementation implements NetworkService {
  @override
  Future<List<Artist>> getArtists(String? searchValue, int offset) async {
    final rawData = searchValue == null
        ? await _getArtistTopRawData(offset)
        : await _getArtistSearchRawData(searchValue, offset);
    List<dynamic> data = rawData['artists'];
    return data.map((artist) => Artist.fromJson(artist)).toList();
  }

  @override
  Future<List<Track>> getTracksTop(String artistId, int offset) async {
    final uri = NapsterApi.artistTopTracks(offset, artistId);
    final rawData = await _httpGetAndDecode(uri) as Map<String, dynamic>;
    List<dynamic> data = rawData['tracks'];
    return data.map((artist) => Track.fromJson(artist)).toList();
  }

  @override
  Stream<Future<List<Track>>> streamFutureTracks(Stream<List<TrackId>> stream) {
    return stream.map((event) async {
      final trackIdsString = event.join(',');
      if (trackIdsString == '') {
        return [];
      }

      return _getTracklist(trackIdsString);
    });
  }

  Future<Map<String, dynamic>> _getArtistTopRawData(int offset) async {
    final uri = NapsterApi.artistTop(offset);
    return await _httpGetAndDecode(uri) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> _getArtistSearchRawData(
      String searchValue, int offset) async {
    final uri = NapsterApi.artistSearch(offset, searchValue);
    final rawData = await _httpGetAndDecode(uri) as Map<String, dynamic>;
    return rawData['search']['data'] as Map<String, dynamic>;
  }

  Future<List<Track>> _getTracklist(String trackIdsString) async {
    final uri = NapsterApi.tracksList(trackIdsString);
    final rawData = await _httpGetAndDecode(uri) as Map<String, dynamic>;
    List<dynamic> data = rawData['tracks'];
    return data.map((artist) => Track.fromJson(artist)).toList();
  }

  dynamic _httpGetAndDecode(Uri uri) async {
    final response = await http.get(uri);
    return json.decode(response.body);
  }
}

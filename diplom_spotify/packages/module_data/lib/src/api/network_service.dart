import 'package:module_model/module_model.dart';

abstract class NetworkService {
  void initialize();

  Future<List<Artist>> getArtists(String? searchValue);

  Future<List<Track>> getTracksTop(String artistId);

  Stream<List<Track>> streamTracks(Stream stream);
}

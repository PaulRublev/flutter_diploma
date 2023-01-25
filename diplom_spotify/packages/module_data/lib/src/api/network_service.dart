import 'package:module_model/module_model.dart';

abstract class NetworkService {
  Future<List<Artist>> getArtists(String? searchValue, int offset);

  Future<List<Track>> getTracksTop(String artistId, int offset);

  Stream<Future<List<Track>>> streamFutureTracks(Stream<List<TrackId>> stream);
}

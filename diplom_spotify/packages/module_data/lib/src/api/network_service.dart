import 'package:module_model/module_model.dart';

abstract class NetworkService {
  Future<List<Artist>> getArtists(String? searchValue, int offset);

  Future<List<NapsterTrack>> getTopTracks(String artistId, int offset);

  Stream<Future<List<NapsterTrack>>> streamFutureTracks(
      Stream<List<DatabaseTrack>> stream);
}

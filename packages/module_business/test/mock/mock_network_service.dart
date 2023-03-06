import 'package:module_data/module_data.dart';
import 'package:module_model/module_model.dart';

class MockNetworkService implements NetworkService {
  final List<Artist> artists;
  final bool isGetSucceeded;
  final List<NapsterTrack> topTracks;

  const MockNetworkService({
    this.artists = const [],
    this.isGetSucceeded = true,
    this.topTracks = const [],
  });

  @override
  Future<List<Artist>> getArtists(String? searchValue, int offset) async {
    if (isGetSucceeded) {
      return artists;
    }
    throw Exception('Artists data failure');
  }

  @override
  Future<List<NapsterTrack>> getTopTracks(String artistId, int offset) async {
    if (isGetSucceeded) {
      return topTracks;
    }
    throw Exception('Top tracks data failure');
  }

  @override
  Future<List<NapsterTrack>> getTracklist(
      List<DatabaseTrack> databaseTracks) async {
    if (isGetSucceeded) {
      List<NapsterTrack> tracks = databaseTracks
          .map((e) => NapsterTrack(
                id: e.id,
                name: 'name',
                albumName: 'albumName',
                albumId: 'albumId',
                previewURL: 'previewURL',
              ))
          .toList();
      return tracks;
    }
    throw Exception('Tracklist data failure');
  }

  @override
  Stream<Future<List<NapsterTrack>>> streamFutureTracks(
      Stream<List<DatabaseTrack>> stream) {
    return stream.map((event) async {
      return getTracklist(event);
    });
  }
}

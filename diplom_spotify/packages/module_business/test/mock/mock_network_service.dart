import 'package:module_data/module_data.dart';
import 'package:module_model/module_model.dart';

class MockNetworkService implements NetworkService {
  @override
  Future<List<Artist>> getArtists(String? searchValue, int offset) async {
    return [Artist(id: 'id', name: 'name', blurbs: [])];
  }

  @override
  Future<List<NapsterTrack>> getTopTracks(String artistId, int offset) async {
    return [
      NapsterTrack(
        id: 'id',
        name: 'name',
        albumName: 'albumName',
        albumId: 'albumId',
        previewURL: 'previewURL',
      )
    ];
  }

  @override
  Future<List<NapsterTrack>> getTracklist(
      List<DatabaseTrack> databaseTracks) async {
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

  @override
  Stream<Future<List<NapsterTrack>>> streamFutureTracks(
      Stream<List<DatabaseTrack>> stream) {
    return Stream.periodic(
      const Duration(seconds: 2),
      (computationCount) async {
        return [
          NapsterTrack(
            id: 'id',
            name: 'name',
            albumName: 'albumName',
            albumId: 'albumId',
            previewURL: 'previewURL',
          )
        ];
      },
    );
  }
}

import 'package:bloc_test/bloc_test.dart';
import 'package:module_business/module_business.dart';
import 'package:module_data/module_data.dart';
import 'package:module_model/module_model.dart';
import 'package:test/test.dart';

import 'mock/mock_network_service.dart';

void main() {
  late TopTracksCubit topTracksCubit;
  late NetworkService networkService;

  group('TopTracksCubit - initial state: ', () {
    setUp(() {
      topTracksCubit = TopTracksCubit(networkService: MockNetworkService());
    });
    test('state is TopTracksState.loading', () {
      expect(topTracksCubit.state, TopTracksState.loading());
    });
  });

  group('Test getInitialTopTracks(): ', () {
    final track = NapsterTrack(
      id: 'id',
      name: 'name',
      albumName: 'albumName',
      albumId: 'albumId',
      previewURL: 'previewURL',
    );
    setUp(() {
      networkService = MockNetworkService(topTracks: [track]);
      topTracksCubit = TopTracksCubit(networkService: networkService);
    });
    blocTest(
      'emits [TopTracksState.success] when getInitialTopTracks',
      build: () => topTracksCubit,
      act: (cubit) => cubit.getInitialTopTracks(''),
      expect: () => [
        TopTracksState.loading(),
        TopTracksState.success([track]),
      ],
    );
    blocTest(
      'ensure second call still returns only one item',
      build: () => topTracksCubit,
      seed: () => TopTracksState.success([track, track]),
      act: (cubit) => cubit.getInitialTopTracks(''),
      expect: () => [
        TopTracksState.loading(),
        TopTracksState.success([track]),
      ],
    );
  });

  group('Test subsequent calls: ', () {
    final track1 = NapsterTrack(
      id: 'id1',
      name: 'name',
      albumName: 'albumName',
      albumId: 'albumId',
      previewURL: 'previewURL',
    );
    final track2 = NapsterTrack(
      id: 'id2',
      name: 'name',
      albumName: 'albumName',
      albumId: 'albumId',
      previewURL: 'previewURL',
    );
    setUp(() {
      networkService = MockNetworkService(topTracks: [track1]);
      topTracksCubit = TopTracksCubit(networkService: networkService);
    });
    blocTest(
      'emits [TopTracksState.success] when getTopTracks',
      build: () => topTracksCubit,
      act: (cubit) => cubit.getTopTracks(''),
      expect: () => [
        TopTracksState.waiting([]),
        TopTracksState.success([track1]),
      ],
    );
    blocTest(
      'emits [TopTracksState.success] when getTopTracks with seed',
      build: () => topTracksCubit,
      seed: () => TopTracksState.success([track2]),
      act: (cubit) => cubit.getTopTracks(''),
      expect: () => [
        TopTracksState.waiting([track2]),
        TopTracksState.success([track2, track1]),
      ],
    );
  });

  group('Test error: ', () {
    final track = NapsterTrack(
      id: 'id',
      name: 'name',
      albumName: 'albumName',
      albumId: 'albumId',
      previewURL: 'previewURL',
    );
    setUp(() {
      networkService = MockNetworkService(isGetSucceeded: false);
      topTracksCubit = TopTracksCubit(networkService: networkService);
    });
    blocTest(
      'emits [TopTracksState.failure] when getInitialTopTracks',
      build: () => topTracksCubit,
      act: (cubit) => cubit.getInitialTopTracks(''),
      expect: () => [
        TopTracksState.loading(),
        TopTracksState.failure([]),
      ],
    );
    blocTest(
      'emits [TopTracksState.failure] when getTopTracks',
      build: () => topTracksCubit,
      seed: () => TopTracksState.success([track]),
      act: (cubit) => cubit.getTopTracks(''),
      expect: () => [
        TopTracksState.waiting([track]),
        TopTracksState.failure([track]),
      ],
    );
  });
}

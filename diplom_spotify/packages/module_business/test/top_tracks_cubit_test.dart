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
      topTracksCubit =
          TopTracksCubit(networkService: const MockNetworkService());
    });
    test('state is TopTracksState.loading', () {
      expect(topTracksCubit.state, const TopTracksState.loading());
    });
  });

  group('Test getInitialTopTracks(): ', () {
    const track = NapsterTrack(
      id: 'id',
      name: 'name',
      albumName: 'albumName',
      albumId: 'albumId',
      previewURL: 'previewURL',
    );
    setUp(() {
      networkService = const MockNetworkService(topTracks: [track]);
      topTracksCubit = TopTracksCubit(networkService: networkService);
    });
    blocTest(
      'emits [TopTracksState.success] when getInitialTopTracks',
      build: () => topTracksCubit,
      act: (cubit) => cubit.getInitialTopTracks(''),
      expect: () => [
        const TopTracksState.loading(),
        const TopTracksState.success([track]),
      ],
    );
    blocTest(
      'ensure second call still returns only one item',
      build: () => topTracksCubit,
      seed: () => const TopTracksState.success([track, track]),
      act: (cubit) => cubit.getInitialTopTracks(''),
      expect: () => [
        const TopTracksState.loading(),
        const TopTracksState.success([track]),
      ],
    );
  });

  group('Test subsequent calls: ', () {
    const track1 = NapsterTrack(
      id: 'id1',
      name: 'name',
      albumName: 'albumName',
      albumId: 'albumId',
      previewURL: 'previewURL',
    );
    const track2 = NapsterTrack(
      id: 'id2',
      name: 'name',
      albumName: 'albumName',
      albumId: 'albumId',
      previewURL: 'previewURL',
    );
    setUp(() {
      networkService = const MockNetworkService(topTracks: [track1]);
      topTracksCubit = TopTracksCubit(networkService: networkService);
    });
    blocTest(
      'emits [TopTracksState.success] when getTopTracks',
      build: () => topTracksCubit,
      act: (cubit) => cubit.getTopTracks(''),
      expect: () => [
        const TopTracksState.waiting([]),
        const TopTracksState.success([track1]),
      ],
    );
    blocTest(
      'emits [TopTracksState.success] when getTopTracks with seed',
      build: () => topTracksCubit,
      seed: () => const TopTracksState.success([track2]),
      act: (cubit) => cubit.getTopTracks(''),
      expect: () => [
        const TopTracksState.waiting([track2]),
        const TopTracksState.success([track2, track1]),
      ],
    );
  });

  group('Test error: ', () {
    const track = NapsterTrack(
      id: 'id',
      name: 'name',
      albumName: 'albumName',
      albumId: 'albumId',
      previewURL: 'previewURL',
    );
    setUp(() {
      networkService = const MockNetworkService(isGetSucceeded: false);
      topTracksCubit = TopTracksCubit(networkService: networkService);
    });
    blocTest(
      'emits [TopTracksState.failure] when getInitialTopTracks',
      build: () => topTracksCubit,
      act: (cubit) => cubit.getInitialTopTracks(''),
      expect: () => [
        const TopTracksState.loading(),
        const TopTracksState.failure([]),
      ],
    );
    blocTest(
      'emits [TopTracksState.failure] when getTopTracks',
      build: () => topTracksCubit,
      seed: () => const TopTracksState.success([track]),
      act: (cubit) => cubit.getTopTracks(''),
      expect: () => [
        const TopTracksState.waiting([track]),
        const TopTracksState.failure([track]),
      ],
    );
  });
}

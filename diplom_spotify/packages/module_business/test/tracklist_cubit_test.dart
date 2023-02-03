import 'package:bloc_test/bloc_test.dart';
import 'package:module_business/module_business.dart';
import 'package:module_model/module_model.dart';
import 'package:test/test.dart';

import 'mock/mock_firebase_service.dart';
import 'mock/mock_network_service.dart';

void main() async {
  late TracklistCubit tracklistCubit;
  final NapsterTrack track1 = NapsterTrack(
    id: 'id1',
    name: 'name',
    albumName: 'albumName',
    albumId: 'albumId',
    previewURL: 'previewURL',
  );
  final NapsterTrack track2 = NapsterTrack(
    id: 'id2',
    name: 'name',
    albumName: 'albumName',
    albumId: 'albumId',
    previewURL: 'previewURL',
  );
  final dbTrack1 = DatabaseTrack(id: 'id1', timestamp: 1);
  final dbTrack2 = DatabaseTrack(id: 'id2', timestamp: 2);

  group('TracklistCubit - initial state: ', () {
    setUp(() {
      tracklistCubit = TracklistCubit(
        networkService: MockNetworkService(),
        firebaseService: MockFirebaseService(),
      );
    });
    test('state is TracklistState.loading', () {
      expect(tracklistCubit.state, TracklistState.loading());
    });
  });

  group('Test addTrack: ', () {
    setUp(() {
      tracklistCubit = TracklistCubit(
        networkService: MockNetworkService(),
        firebaseService: MockFirebaseService(databaseTracks: [dbTrack1]),
      );
    });
    blocTest(
      'emits [TracklistState.success] when addTrack',
      build: () => tracklistCubit,
      act: (cubit) => cubit.addTrack(track2),
      setUp: () async {
        await tracklistCubit.getTracklist();
      },
      expect: () => [
        TracklistState.success(
            [track2, track1], tracklistCubit.state.isDescendent),
      ],
    );
  });

  group('Test removeTrack: ', () {
    setUp(() {
      tracklistCubit = TracklistCubit(
        networkService: MockNetworkService(),
        firebaseService:
            MockFirebaseService(databaseTracks: [dbTrack1, dbTrack2]),
      );
    });
    blocTest(
      'emits [TracklistState.success] when removeTrack',
      build: () => tracklistCubit,
      act: (cubit) => cubit.removeTrack(track1),
      setUp: () async {
        await tracklistCubit.getTracklist();
      },
      expect: () => [
        TracklistState.success([track2], tracklistCubit.state.isDescendent),
      ],
    );
  });

  group('Test getTracklist: ', () {
    setUp(() {
      tracklistCubit = TracklistCubit(
        networkService: MockNetworkService(),
        firebaseService:
            MockFirebaseService(databaseTracks: [dbTrack1, dbTrack2]),
      );
    });
    blocTest(
      'emits [TracklistState.success] when getTracklist',
      build: () => tracklistCubit,
      act: (cubit) async => await cubit.getTracklist(),
      expect: () => [
        TracklistState.success(
            [track2, track1], tracklistCubit.state.isDescendent),
      ],
    );
  });

  group('Test changeSortDirection: ', () {
    setUp(() {
      tracklistCubit = TracklistCubit(
        networkService: MockNetworkService(),
        firebaseService:
            MockFirebaseService(databaseTracks: [dbTrack1, dbTrack2]),
      );
    });
    blocTest(
      'emits [TracklistState.changingSortDirection, TracklistState.success] when changeSortDirection',
      build: () => tracklistCubit,
      act: (cubit) => cubit.changeSortDirection(),
      setUp: () async {
        await tracklistCubit.getTracklist();
      },
      expect: () => [
        TracklistState.changingSortDirection(
          [track2, track1],
          !tracklistCubit.state.isDescendent,
        ),
        TracklistState.success(
          [track1, track2],
          tracklistCubit.state.isDescendent,
        ),
      ],
    );
  });

  group('Test error: ', () {
    setUp(() {
      tracklistCubit = TracklistCubit(
        networkService: MockNetworkService(isGetSucceeded: false),
        firebaseService:
            MockFirebaseService(databaseTracks: [dbTrack1, dbTrack2]),
      );
    });

    blocTest(
      'emits [TracklistState.failure] when getTracklist',
      build: () => tracklistCubit,
      act: (cubit) => cubit.getTracklist(),
      expect: () => [
        TracklistState.failure([], tracklistCubit.state.isDescendent),
      ],
    );

    blocTest(
      'emits [TracklistState.failure] when getTracklist with seed',
      build: () => tracklistCubit,
      act: (cubit) => cubit.getTracklist(),
      seed: () => TracklistState.success([track1], true),
      expect: () => [
        TracklistState.failure([track1], tracklistCubit.state.isDescendent),
      ],
    );
  });
}

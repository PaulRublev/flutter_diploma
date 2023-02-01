import 'package:bloc_test/bloc_test.dart';
import 'package:module_business/module_business.dart';
import 'package:module_model/module_model.dart';
import 'package:test/test.dart';

import 'mock/mock_business_layer.dart';
import 'mock/mock_firebase_service.dart';

void main() async {
  late TracklistCubit tracklistCubit;
  final MockFirebaseService firebaseService =
      MockBusinessLayer.instance.firebaseService as MockFirebaseService;
  NapsterTrack track1 = NapsterTrack(
    id: 'id',
    name: 'name',
    albumName: 'albumName',
    albumId: 'albumId',
    previewURL: 'previewURL',
  );
  NapsterTrack track2 = NapsterTrack(
    id: 'id2',
    name: 'name',
    albumName: 'albumName',
    albumId: 'albumId',
    previewURL: 'previewURL',
  );
  final List<DatabaseTrack> databaseTracks = [
    DatabaseTrack(id: 'id', timestamp: 1)
  ];
  await MockBusinessLayer.instance.initialize();

  group('TracklistCubit', () {
    setUp(() {
      tracklistCubit = TracklistCubit();
    });
    test('initial state is TracklistState.loading', () {
      expect(tracklistCubit.state, TracklistState.loading());
    });

    blocTest(
      'emits [TracklistState.success] when addTrack',
      build: () => tracklistCubit,
      act: (cubit) => cubit.addTrack(track2),
      setUp: () async {
        firebaseService.databaseTracks = List.from(databaseTracks);
        await tracklistCubit.getTracklist();
      },
      expect: () => [
        TracklistState.success(
            [track2, track1], tracklistCubit.state.isDescendent),
      ],
    );

    blocTest(
      'emits [TracklistState.success] when removeTrack',
      build: () => tracklistCubit,
      act: (cubit) => cubit.removeTrack(track1),
      setUp: () async {
        firebaseService.databaseTracks = List.from(databaseTracks);
        tracklistCubit.addTrack(track2);
        await tracklistCubit.getTracklist();
      },
      expect: () => [
        TracklistState.success([track2], tracklistCubit.state.isDescendent),
      ],
    );

    blocTest(
      'emits [TracklistState.success] when getTracklist',
      build: () => tracklistCubit,
      act: (cubit) async => await cubit.getTracklist(),
      setUp: () async {
        firebaseService.databaseTracks = List.from(databaseTracks);
      },
      expect: () => [
        TracklistState.success([track1], tracklistCubit.state.isDescendent),
      ],
    );

    blocTest(
      'emits [TracklistState.changingSortDirection, TracklistState.success] when changeSortDirection',
      build: () => tracklistCubit,
      act: (cubit) => cubit.changeSortDirection(),
      setUp: () async {
        firebaseService.databaseTracks = List.from(databaseTracks);
        tracklistCubit.addTrack(track2);
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
}

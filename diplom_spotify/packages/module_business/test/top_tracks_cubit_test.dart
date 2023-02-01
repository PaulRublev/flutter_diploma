import 'package:bloc_test/bloc_test.dart';
import 'package:module_business/module_business.dart';
import 'package:module_model/module_model.dart';
import 'package:test/test.dart';

import 'mock/mock_business_layer.dart';

void main() {
  late TopTracksCubit topTracksCubit;
  MockBusinessLayer.instance.initialize();

  group('TopTracksCubit', () {
    setUp(() {
      topTracksCubit = TopTracksCubit();
    });
    test('initial state is TopTracksState.loading', () {
      expect(topTracksCubit.state, TopTracksState.loading());
    });

    final track = NapsterTrack(
      id: 'id',
      name: 'name',
      albumName: 'albumName',
      albumId: 'albumId',
      previewURL: 'previewURL',
    );
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
      'emits [TopTracksState.success] when getTopTracks',
      build: () => topTracksCubit,
      act: (cubit) => cubit.getTopTracks(''),
      seed: () {
        return TopTracksState.success([track]);
      },
      expect: () => [
        TopTracksState.waiting([track]),
        TopTracksState.success([track, track]),
      ],
    );
  });
}

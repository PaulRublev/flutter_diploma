import 'package:module_business/module_business.dart';
import 'package:module_model/module_model.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

import 'mock/mock_business_layer.dart';

void main() {
  late ArtistsCubit artistsCubit;
  MockBusinessLayer.instance.initialize();

  group('ArtistsCubit', () {
    setUp(() {
      artistsCubit = ArtistsCubit();
    });
    test('initial state is ArtistsState.loading', () {
      expect(artistsCubit.state, ArtistsState.loading());
    });

    final artist = Artist(id: 'id', name: 'name', blurbs: []);
    blocTest(
      'emits [ArtistsState.success] when getInitialArtists',
      build: () => artistsCubit,
      act: (cubit) => cubit.getInitialArtists(),
      expect: () => [
        ArtistsState.loading(),
        ArtistsState.success([artist]),
      ],
    );

    blocTest(
      'emits [ArtistsState.success] when getArtists',
      build: () => artistsCubit,
      act: (cubit) => cubit.getArtists(),
      seed: () {
        return ArtistsState.success([artist]);
      },
      expect: () => [
        ArtistsState.success([artist, artist])
      ],
    );
  });
}

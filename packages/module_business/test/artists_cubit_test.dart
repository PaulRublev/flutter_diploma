import 'package:module_business/module_business.dart';
import 'package:module_data/module_data.dart';
import 'package:module_model/module_model.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

import 'mock/mock_network_service.dart';

void main() {
  late ArtistsCubit artistsCubit;
  late NetworkService networkService;

  group('ArtistsCubit - initial state: ', () {
    setUp(() {
      artistsCubit = ArtistsCubit(networkService: const MockNetworkService());
    });
    test('state is ArtistsState.loading', () {
      expect(artistsCubit.state, const ArtistsState.loading());
    });
  });

  group('Test getInitialArtists(): ', () {
    const artist = Artist(id: 'id', name: 'name', blurbs: []);
    setUp(() {
      networkService = const MockNetworkService(artists: [artist]);
      artistsCubit = ArtistsCubit(networkService: networkService);
    });
    blocTest(
      'emits [ArtistsState.success] when getInitialArtists',
      build: () => artistsCubit,
      act: (cubit) => cubit.getInitialArtists(),
      expect: () => [
        const ArtistsState.loading(),
        const ArtistsState.success([artist]),
      ],
    );
    blocTest(
      'ensure second call still returns only one item',
      build: () => artistsCubit,
      seed: () => const ArtistsState.success([artist, artist]),
      act: (cubit) => cubit.getInitialArtists(),
      expect: () => [
        const ArtistsState.loading(),
        const ArtistsState.success([artist]),
      ],
    );
  });

  group('Test subsequent calls: ', () {
    const artist = Artist(id: 'id', name: 'name', blurbs: []);
    setUp(() {
      networkService = const MockNetworkService(artists: [artist]);
      artistsCubit = ArtistsCubit(networkService: networkService);
    });

    blocTest(
      'emits [ArtistsState.success] when getArtists',
      build: () => artistsCubit,
      act: (cubit) => cubit.getArtists(),
      expect: () => [
        const ArtistsState.success([artist]),
      ],
    );

    blocTest(
      'emits [ArtistsState.success] when getArtists with seed',
      build: () => artistsCubit,
      seed: () => const ArtistsState.success([artist]),
      act: (cubit) => cubit.getArtists(),
      expect: () => [
        const ArtistsState.success([artist, artist]),
      ],
    );
  });

  group('Test error: ', () {
    setUp(() {
      networkService = const MockNetworkService(isGetSucceeded: false);
      artistsCubit = ArtistsCubit(networkService: networkService);
    });

    blocTest(
      'emits [ArtistsState.failure] when getInitialArtists',
      build: () => artistsCubit,
      act: (cubit) => cubit.getInitialArtists(),
      expect: () => [
        const ArtistsState.loading(),
        const ArtistsState.failure([]),
      ],
    );

    blocTest(
      'emits [ArtistsState.failure] when getArtists',
      build: () => artistsCubit,
      act: (cubit) => cubit.getArtists(),
      expect: () => [
        const ArtistsState.failure([]),
      ],
    );
  });
}

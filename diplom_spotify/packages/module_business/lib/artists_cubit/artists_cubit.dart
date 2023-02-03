import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_business/artists_cubit/artists_state.dart';
import 'package:module_data/module_data.dart';
import 'package:module_model/module_model.dart';

class ArtistsCubit extends Cubit<ArtistsState> {
  final NetworkService _networkService;

  ArtistsCubit({NetworkService? networkService})
      : _networkService =
            networkService ?? ServiceProvider.instance.networkService,
        super(ArtistsState.loading());

  Future<void> getInitialArtists({String? searchValue}) async {
    emit(ArtistsState.loading());
    try {
      final List<Artist> tmpArtists = [];
      tmpArtists.addAll(await _networkService.getArtists(searchValue, 0));
      emit(ArtistsState.success(tmpArtists));
    } catch (_) {
      emit(ArtistsState.failure(state.artists));
    }
  }

  Future<void> getArtists({String? searchValue}) async {
    try {
      final List<Artist> tmpArtists = List.from(state.artists);
      tmpArtists.addAll(
          await _networkService.getArtists(searchValue, state.artists.length));
      emit(ArtistsState.success(tmpArtists));
    } catch (_) {
      emit(ArtistsState.failure(state.artists));
    }
  }
}

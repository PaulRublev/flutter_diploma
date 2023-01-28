import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_business/src/artists_state.dart';
import 'package:module_data/module_data.dart';
import 'package:module_model/module_model.dart';

class SearchArtistsCubit extends Cubit<ArtistsState> {
  SearchArtistsCubit() : super(ArtistsState.loading());

  final networkService = ServiceProvider.instance.get<NetworkService>();
  final List<Artist> artists = <Artist>[];

  Future<void> getArtists(String? searchValue) async {
    emit(ArtistsState.waiting(artists));
    try {
      artists.addAll(
          await networkService.getArtists(searchValue, state.artists.length));
      emit(ArtistsState.success(artists));
    } on Exception {
      emit(ArtistsState.failure(artists));
    }
  }

  void setLoadingState() {
    artists.clear();
    emit(ArtistsState.loading());
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_business/src/artists_state.dart';
import 'package:module_data/module_data.dart';
import 'package:module_model/module_model.dart';

class ArtistsCubit extends Cubit<ArtistsState> {
  ArtistsCubit() : super(ArtistsState.loading());

  final networkService = ServiceProvider.instance.get<NetworkService>();
  final List<Artist> artists = <Artist>[];

  Future<void> getArtists(String? value) async {
    emit(ArtistsState.waiting(artists));
    try {
      artists
          .addAll(await networkService.getArtists(null, state.artists.length));
      emit(ArtistsState.success(artists));
    } on Exception {
      emit(ArtistsState.failure(artists));
    }
  }
}

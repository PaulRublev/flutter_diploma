import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_business/top_tracks_cubit/top_tracks_state.dart';
import 'package:module_data/module_data.dart';
import 'package:module_model/module_model.dart';

class TopTracksCubit extends Cubit<TopTracksState> {
  TopTracksCubit({NetworkService? networkService})
      : _networkService =
            networkService ?? ServiceProvider.instance.networkService,
        super(const TopTracksState.loading());

  final NetworkService _networkService;

  Future<void> getInitialTopTracks(String artistId) async {
    emit(const TopTracksState.loading());
    try {
      final List<NapsterTrack> tmpTracks = [];
      tmpTracks.addAll(
          await _networkService.getTopTracks(artistId, tmpTracks.length));
      emit(TopTracksState.success(tmpTracks));
    } on Exception {
      emit(TopTracksState.failure(state.tracks));
    }
  }

  Future<void> getTopTracks(String artistId) async {
    emit(TopTracksState.waiting(state.tracks));
    try {
      final List<NapsterTrack> tmpTracks = List.from(state.tracks);
      tmpTracks.addAll(
          await _networkService.getTopTracks(artistId, tmpTracks.length));
      emit(TopTracksState.success(tmpTracks));
    } on Exception {
      emit(TopTracksState.failure(state.tracks));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_business/tracklist_cubit/tracklist_state.dart';
import 'package:module_data/module_data.dart';
import 'package:module_model/module_model.dart';

class TracklistCubit extends Cubit<TracklistState> {
  TracklistCubit({
    NetworkService? networkService,
    FirebaseService? firebaseService,
  })  : _networkService =
            networkService ?? ServiceProvider.instance.networkService,
        _firebaseService =
            firebaseService ?? ServiceProvider.instance.firebaseService,
        super(TracklistState.loading());

  final NetworkService _networkService;
  final FirebaseService _firebaseService;
  final List<DatabaseTrack> _databaseTracks = [];

  Future<void> getTracklist() async {
    try {
      final List<NapsterTrack> tmpTracks = [];
      _databaseTracks.clear();
      _databaseTracks.addAll(await _firebaseService.getDatabaseTracks().then(
        (value) {
          value.sort(_compareDatabaseTracks);
          return value;
        },
      ));
      tmpTracks.addAll(await _networkService.getTracklist(_databaseTracks));
      emit(TracklistState.success(tmpTracks, state.isDescendent));
    } on Exception {
      emit(TracklistState.failure(state.tracks, state.isDescendent));
    }
  }

  void changeSortDirection() {
    emit(TracklistState.changingSortDirection(
        state.tracks, !state.isDescendent));
    _databaseTracks.sort(_compareDatabaseTracks);
    final List<NapsterTrack> tmpTracks = List.from(state.tracks);
    emit(TracklistState.success(_sort(tmpTracks), state.isDescendent));
  }

  void addTrack(NapsterTrack track) {
    _databaseTracks.add(DatabaseTrack(
      id: track.id,
      timestamp: DateTime.now().millisecondsSinceEpoch,
    ));
    _databaseTracks.sort(_compareDatabaseTracks);
    final List<NapsterTrack> tmpTracks = List.from(state.tracks);
    tmpTracks.add(track);

    emit(TracklistState.success(_sort(tmpTracks), state.isDescendent));
    _firebaseService.addTrack(track.id);
  }

  void removeTrack(NapsterTrack track) {
    _databaseTracks.removeWhere((element) => element.id == track.id);
    final List<NapsterTrack> tmpTracks = List.from(state.tracks);
    tmpTracks.remove(track);
    emit(TracklistState.success(tmpTracks, state.isDescendent));
    _firebaseService.removeTrack(track.id);
  }

  int _compareDatabaseTracks(DatabaseTrack a, DatabaseTrack b) =>
      state.isDescendent
          ? a.timestamp.compareTo(b.timestamp)
          : b.timestamp.compareTo(a.timestamp);

  List<NapsterTrack> _sort(List<NapsterTrack> tracks) {
    final List<NapsterTrack> tmpTracks = List.from(tracks);
    final sortedTracks = _databaseTracks
        .map((e) => tmpTracks.firstWhere((element) => element.id == e.id))
        .toList();
    return sortedTracks;
  }
}

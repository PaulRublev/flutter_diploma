import 'package:module_model/module_model.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart' show DeepCollectionEquality;

enum TopTracksStatus { loading, success, failure, waiting }

class TopTracksState {
  final TopTracksStatus status;
  final List<NapsterTrack> tracks;
  final bool Function(dynamic e1, dynamic e2) _deepEquals =
      const DeepCollectionEquality().equals;

  TopTracksState._({
    this.status = TopTracksStatus.loading,
    this.tracks = const <NapsterTrack>[],
  });

  TopTracksState.loading() : this._();

  TopTracksState.success(List<NapsterTrack> tracks)
      : this._(
          status: TopTracksStatus.success,
          tracks: tracks,
        );

  TopTracksState.waiting(List<NapsterTrack> tracks)
      : this._(
          status: TopTracksStatus.waiting,
          tracks: tracks,
        );

  TopTracksState.failure(List<NapsterTrack> tracks)
      : this._(
          status: TopTracksStatus.failure,
          tracks: tracks,
        );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TopTracksState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          _deepEquals(tracks, other.tracks);

  @override
  int get hashCode => Object.hash(status, tracks);
}

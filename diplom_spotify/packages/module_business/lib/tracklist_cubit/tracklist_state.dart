import 'package:module_model/module_model.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart' show DeepCollectionEquality;

enum TracklistStatus { loading, success, failure, changingSortDirection }

class TracklistState {
  final TracklistStatus status;
  final List<NapsterTrack> tracks;
  final bool isDescendent;
  final bool Function(dynamic e1, dynamic e2) _deepEquals =
      const DeepCollectionEquality().equals;

  TracklistState._({
    this.status = TracklistStatus.loading,
    this.tracks = const <NapsterTrack>[],
    this.isDescendent = false,
  });

  TracklistState.loading() : this._();

  TracklistState.success(List<NapsterTrack> tracks, bool isDescendent)
      : this._(
          status: TracklistStatus.success,
          tracks: tracks,
          isDescendent: isDescendent,
        );

  TracklistState.changingSortDirection(
      List<NapsterTrack> tracks, bool isDescendent)
      : this._(
          status: TracklistStatus.changingSortDirection,
          tracks: tracks,
          isDescendent: isDescendent,
        );

  TracklistState.failure(List<NapsterTrack> tracks)
      : this._(
          status: TracklistStatus.failure,
          tracks: tracks,
        );

  @override
  bool operator ==(Object other) =>
      other is TracklistState &&
      runtimeType == other.runtimeType &&
      status == other.status &&
      _deepEquals(tracks, other.tracks);

  @override
  int get hashCode => Object.hash(status, tracks);
}

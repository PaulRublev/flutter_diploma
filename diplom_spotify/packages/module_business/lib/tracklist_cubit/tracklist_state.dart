import 'package:module_model/module_model.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart' show DeepCollectionEquality;

enum TracklistStatus { loading, success, failure, changingSortDirection }

class TracklistState {
  final TracklistStatus status;
  final List<NapsterTrack> tracks;
  final bool isDescendent;

  const TracklistState._({
    this.status = TracklistStatus.loading,
    this.tracks = const <NapsterTrack>[],
    this.isDescendent = false,
  });

  const TracklistState.loading() : this._();

  const TracklistState.success(List<NapsterTrack> tracks, bool isDescendent)
      : this._(
          status: TracklistStatus.success,
          tracks: tracks,
          isDescendent: isDescendent,
        );

  const TracklistState.changingSortDirection(
      List<NapsterTrack> tracks, bool isDescendent)
      : this._(
          status: TracklistStatus.changingSortDirection,
          tracks: tracks,
          isDescendent: isDescendent,
        );

  const TracklistState.failure(List<NapsterTrack> tracks, bool isDescendent)
      : this._(
          status: TracklistStatus.failure,
          tracks: tracks,
          isDescendent: isDescendent,
        );

  @override
  bool operator ==(Object other) =>
      other is TracklistState &&
      runtimeType == other.runtimeType &&
      status == other.status &&
      const DeepCollectionEquality().equals(tracks, other.tracks);

  @override
  int get hashCode => Object.hash(status, tracks);

  @override
  String toString() {
    return '$status, $isDescendent, $tracks';
  }
}

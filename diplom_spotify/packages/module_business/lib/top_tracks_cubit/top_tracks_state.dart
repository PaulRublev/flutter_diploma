import 'package:module_model/module_model.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart' show DeepCollectionEquality;

enum TopTracksStatus { loading, success, failure, waiting }

class TopTracksState {
  final TopTracksStatus status;
  final List<NapsterTrack> tracks;

  const TopTracksState._({
    this.status = TopTracksStatus.loading,
    this.tracks = const <NapsterTrack>[],
  });

  const TopTracksState.loading() : this._();

  const TopTracksState.success(List<NapsterTrack> tracks)
      : this._(
          status: TopTracksStatus.success,
          tracks: tracks,
        );

  const TopTracksState.waiting(List<NapsterTrack> tracks)
      : this._(
          status: TopTracksStatus.waiting,
          tracks: tracks,
        );

  const TopTracksState.failure(List<NapsterTrack> tracks)
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
          const DeepCollectionEquality().equals(tracks, other.tracks);

  @override
  int get hashCode => Object.hash(status, tracks);

  @override
  String toString() => '$status, $tracks';
}

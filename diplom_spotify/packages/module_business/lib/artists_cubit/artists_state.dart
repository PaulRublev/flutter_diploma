import 'package:module_model/module_model.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart' show DeepCollectionEquality;

enum ArtistsStatus { loading, success, failure, waiting }

class ArtistsState {
  final ArtistsStatus status;
  final List<Artist> artists;
  final bool Function(dynamic e1, dynamic e2) deepEquals =
      const DeepCollectionEquality().equals;

  ArtistsState._({
    this.status = ArtistsStatus.loading,
    this.artists = const <Artist>[],
  });

  ArtistsState.loading() : this._();

  ArtistsState.success(List<Artist> artists)
      : this._(
          status: ArtistsStatus.success,
          artists: artists,
        );

  ArtistsState.failure(List<Artist> artists)
      : this._(
          status: ArtistsStatus.failure,
          artists: artists,
        );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArtistsState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          deepEquals(artists, other.artists);

  @override
  int get hashCode => Object.hash(status, artists);
}

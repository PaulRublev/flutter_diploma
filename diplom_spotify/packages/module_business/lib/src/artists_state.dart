import 'package:module_model/module_model.dart';

enum ArtistsStatus { loading, success, failure, waiting }

class ArtistsState {
  final ArtistsStatus status;
  final List<Artist> artists;

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

  ArtistsState.waiting(List<Artist> artists)
      : this._(
          status: ArtistsStatus.waiting,
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
          artists == other.artists;

  @override
  int get hashCode => Object.hash(status, artists);
}

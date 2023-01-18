import 'package:module_model/module_model.dart';

class TrackDb {
  final Track track;
  final DateTime dateTime;

  TrackDb({
    required this.track,
    required this.dateTime,
  });

  TrackDb.fromJson(Map<String, dynamic> json)
      : this(
          track: Track(
            id: json['id'] ?? '',
            name: json['name'] ?? '',
            albumName: json['albumName'] ?? '',
            albumId: json['albumId'] ?? '',
            previewURL: json['previewURL'] ?? '',
          ),
          dateTime: json['dateTime'] ?? const Duration(milliseconds: 0),
        );

  Map<String, Object?> toJson() {
    return {
      'id': track.id,
      'name': track.name,
      'albumName': track.albumName,
      'albumId': track.albumId,
      'previewURL': track.previewURL,
      'dateTime': dateTime,
    };
  }
}

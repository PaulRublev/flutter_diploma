class Track {
  final String id;
  final String name;
  final String albumName;
  final String albumId;
  final String previewURL;

  Track({
    required this.name,
    required this.id,
    required this.albumName,
    required this.albumId,
    required this.previewURL,
  });

  Track.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] ?? '',
          name: json['name'] ?? '',
          albumName: json['albumName'] ?? '',
          albumId: json['albumId'] ?? '',
          previewURL: json['previewURL'] ?? '',
        );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'albumName': albumName,
      'albumId': albumId,
      'previewURL': previewURL,
    };
  }

  @override
  String toString() {
    return "id: $id\nname: $name\nalbumName: $albumName\nalbumId: $albumId\n"
        "previewURL: $previewURL\n";
  }

  @override
  bool operator ==(Object other) {
    return other is Track && id == other.id;
  }

  @override
  int get hashCode => Object.hash(id, name, albumId, albumName, previewURL);
}

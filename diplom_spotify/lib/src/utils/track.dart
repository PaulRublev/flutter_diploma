class Track {
  final String? id;
  final String? name;
  final String? albumName;
  final String? albumId;
  final String? previewURL;

  Track({
    this.name,
    this.id,
    this.albumName,
    this.albumId,
    this.previewURL,
  });

  Track.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          name: json['name'],
          albumName: json['albumName'],
          albumId: json['albumId'],
          previewURL: json['previewURL'],
        );

  @override
  String toString() {
    return 'id: $id\nname: $name\nalbumName: $albumName\nalbumId: $albumId\npreviewURL: $previewURL\n';
  }
}

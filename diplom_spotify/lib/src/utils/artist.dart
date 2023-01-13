class Artist {
  final String id;
  final String name;
  final List<dynamic> blurbs;

  Artist({
    required this.name,
    required this.blurbs,
    required this.id,
  });

  Artist.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] ?? '',
          name: json['name'] ?? '',
          blurbs: json['blurbs'] ?? [],
        );

  @override
  String toString() {
    return 'id: $id\nname: $name\nblurbs: $blurbs';
  }
}

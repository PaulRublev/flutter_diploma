class TrackId {
  final String id;
  final int duration;

  TrackId({
    required this.id,
    required this.duration,
  });

  TrackId.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] ?? '',
          duration: json['duration'] ?? const Duration(milliseconds: 0),
        );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'duration': duration,
    };
  }

  @override
  String toString() => id;
}

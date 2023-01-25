class DatabaseTrack {
  final String id;
  final int timestamp;

  DatabaseTrack({
    required this.id,
    required this.timestamp,
  });

  DatabaseTrack.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] ?? '',
          timestamp: json['timestamp'] ?? const Duration(milliseconds: 0),
        );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'timestamp': timestamp,
    };
  }

  @override
  String toString() => id;
}

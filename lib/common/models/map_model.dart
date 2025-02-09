class MapMarker {
  final String id;
  final String title;
  final String description;
  final double latitude;
  final double longitude;

  MapMarker({
    required this.id,
    required this.title,
    required this.description,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory MapMarker.fromMap(Map<String, dynamic> map, String id) {
    return MapMarker(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      latitude: map['latitude']?.toDouble() ?? 0.0,
      longitude: map['longitude']?.toDouble() ?? 0.0,
    );
  }
}
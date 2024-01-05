class Room {
  final String name;
  final double latitude;
  final double longitude;

  const Room({
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      name: json['name'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
    );
  }
}

import 'package:flutter_demo/src/sample_feature/dto/dto.dart';

class GeoDto implements Dto {
  final String lat;
  final String lng;

  const GeoDto({
    required this.lat,
    required this.lng,
  });

  @override
  factory GeoDto.fromJson(Map<String, dynamic> json) {
    return GeoDto(
      lat: json['lat'],
      lng: json['lng'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {'lat': lat, 'lng': lng};
}

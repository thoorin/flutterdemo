import 'package:flutter_demo/src/sample_feature/dto/dto.dart';
import 'package:flutter_demo/src/sample_feature/dto/geo_dto.dart';

class AddressDto implements Dto {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final GeoDto geo;

  const AddressDto({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

  @override
  factory AddressDto.fromJson(Map<String, dynamic> json) {
    return AddressDto(
      street: json['street'],
      suite: json['suite'],
      city: json['city'],
      zipcode: json['zipcode'],
      geo: GeoDto.fromJson(json['geo']),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'street': street,
        'suite': suite,
        'city': city,
        'zipcode': zipcode,
        'geo': geo.toJson(),
      };
}

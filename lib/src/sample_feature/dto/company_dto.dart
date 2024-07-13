import 'package:flutter_demo/src/sample_feature/dto/dto.dart';

class CompanyDto implements Dto {
  final String name;
  final String catchPhrase;
  final String bs;

  const CompanyDto({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  @override
  factory CompanyDto.fromJson(Map<String, dynamic> json) {
    return CompanyDto(
      name: json['name'],
      catchPhrase: json['catchPhrase'],
      bs: json['bs'],
    );
  }
}

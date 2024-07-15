import 'package:flutter_demo/src/sample_feature/dto/address_dto.dart';
import 'package:flutter_demo/src/sample_feature/dto/company_dto.dart';
import 'package:flutter_demo/src/sample_feature/dto/dto.dart';

class UserDto implements Dto {
  final int id;
  final String name;
  final String username;
  final String email;
  final AddressDto address;
  final String phone;
  final String website;
  final CompanyDto company;

  const UserDto({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  @override
  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      address: AddressDto.fromJson(json['address']),
      phone: json['phone'],
      website: json['website'],
      company: CompanyDto.fromJson(json['company']),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'username': username,
        'email': email,
        'address': address.toJson(),
        'phone': phone,
        'website': website,
        'company': company.toJson()
      };
}

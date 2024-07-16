import 'package:flutter_demo/src/api/dto/dto.dart';

class AlbumDto implements Dto {
  final int userId;
  final int id;
  final String title;

  AlbumDto({
    required this.userId,
    required this.id,
    required this.title,
  });

  @override
  factory AlbumDto.fromJson(Map<String, dynamic> json) {
    return AlbumDto(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'userId': userId,
        'id': id,
        'title': title,
      };
}

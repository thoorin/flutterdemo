import 'package:flutter_demo/src/sample_feature/dto/dto.dart';

class PostDto implements Dto {
  final int userId;
  final int id;
  final String title;
  final String body;

  const PostDto({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  @override
  factory PostDto.fromJson(Map<String, dynamic> json) {
    return PostDto(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

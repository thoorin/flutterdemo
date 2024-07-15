import 'package:flutter_demo/src/api/dto/dto.dart';

class CommentDto implements Dto {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  const CommentDto({
    required this.postId,
    required this.name,
    required this.email,
    required this.body,
    required this.id,
  });

  @override
  factory CommentDto.fromJson(Map<String, dynamic> json) {
    return CommentDto(
      postId: json['postId'],
      id: json['id'],
      name: json['name'],
      email: json['email'],
      body: json['body'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'postId': postId,
        'id': id,
        'name': name,
        'email': email,
        'body': body,
      };
}

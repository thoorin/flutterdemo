import 'package:flutter_demo/src/api/dto/dto.dart';

class SendCommentDto implements Dto {
  final int postId;
  final String name;
  final String email;
  final String body;

  const SendCommentDto({
    required this.postId,
    required this.name,
    required this.email,
    required this.body,
  });

  @override
  factory SendCommentDto.fromJson(Map<String, dynamic> json) {
    return SendCommentDto(
      postId: json['postId'],
      name: json['name'],
      email: json['email'],
      body: json['body'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'postId': postId.toString(),
        'name': name,
        'email': email,
        'body': body,
      };
}

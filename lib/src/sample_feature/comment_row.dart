import 'package:flutter/material.dart';
import 'package:flutter_demo/src/sample_feature/dto/comment_dto.dart';

class CommentRow extends StatelessWidget {
  const CommentRow({
    super.key,
    required this.comment,
  });

  final CommentDto comment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            comment.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            'From: ${comment.email}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            comment.body,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

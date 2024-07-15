import 'package:flutter/material.dart';
import 'package:flutter_demo/src/api/dto/send_comment_dto.dart';
import 'package:flutter_demo/src/api/requests.dart';

Future<dynamic> showAddCommentBottomSheet(
  BuildContext context, {
  required int postId,
}) {
  var emailController = TextEditingController();
  var commentController = TextEditingController();

  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 16,
          left: 16,
          right: 16,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your email',
                    ),
                  ),
                  TextField(
                    controller: commentController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your comment',
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
                onPressed: () async {
                  await Requests.postComment(
                    SendCommentDto(
                      postId: postId,
                      // name would be authUser's name
                      name: 'Marek Škreko',
                      email: emailController.value.text,
                      body: commentController.value.text,
                    ),
                  );

                  if (!context.mounted) return;
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.send),
                color: Theme.of(context).primaryColor),
          ],
        ),
      );
    },
  );
}

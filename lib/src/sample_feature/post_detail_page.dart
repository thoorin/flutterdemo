import 'package:flutter/material.dart';
import 'package:flutter_demo/src/sample_feature/dto/comment_dto.dart';
import 'package:flutter_demo/src/sample_feature/page_state.dart';
import 'package:flutter_demo/src/sample_feature/post.dart';
import 'package:flutter_demo/src/sample_feature/post_row.dart';
import 'package:flutter_demo/src/sample_feature/requests.dart';
import 'package:flutter_demo/src/sample_feature/show_add_comment_bottom_sheet.dart';

class PostDetailPage extends StatefulWidget {
  const PostDetailPage({super.key, required this.post});

  final Post post;
  static const routeName = '/post_detail';

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  bool isInitialized = false;
  PageState pageState = LoadingState();

  void _loadComments() async {
    try {
      RequestResult<List<CommentDto>> getCommentsResult =
          await Requests.getComments(widget.post.id);

      if (getCommentsResult.statusCode != 200) {
        throw Error();
      }

      setState(() {
        pageState = LoadedDetailState(comments: getCommentsResult.data ?? []);
      });
    } catch (_) {
      setState(() {
        pageState = const ErrorState("Error loading comments.");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isInitialized) {
      isInitialized = true;
      _loadComments();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Detail'),
      ),
      body: Column(
        children: [
          PostRow(post: widget.post),
          ElevatedButton(
            onPressed: () {
              showAddCommentBottomSheet(context, postId: widget.post.id);
            },
            child: const Text('Reply'),
          ),
          Expanded(child: pageState.getWidget()),
        ],
      ),
    );
  }
}

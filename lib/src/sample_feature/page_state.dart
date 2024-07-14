import 'package:flutter/material.dart';
import 'package:flutter_demo/src/sample_feature/comment_row.dart';
import 'package:flutter_demo/src/sample_feature/dto/comment_dto.dart';
import 'package:flutter_demo/src/sample_feature/post.dart';
import 'package:flutter_demo/src/sample_feature/post_detail_page.dart';
import 'package:flutter_demo/src/sample_feature/post_row.dart';

abstract interface class PageState {
  Widget getWidget();
}

class LoadingState implements PageState {
  @override
  Widget getWidget() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class LoadedDetailState implements PageState {
  final List<CommentDto> comments;

  LoadedDetailState({required this.comments});

  @override
  Widget getWidget() {
    return ListView.builder(
      restorationId: 'commentsView',
      itemCount: comments.length,
      itemBuilder: (BuildContext context, int index) {
        final comment = comments[index];

        return CommentRow(comment: comment);
      },
    );
  }
}

class LoadedPostsState implements PageState {
  final List<Post> posts;

  LoadedPostsState({required this.posts});

  @override
  Widget getWidget() {
    return ListView.builder(
      restorationId: 'postsView',
      itemCount: posts.length,
      itemBuilder: (BuildContext context, int index) {
        final post = posts[index];

        return GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              PostDetailPage.routeName,
              arguments: post,
            );
          },
          child: PostRow(post: post),
        );
      },
    );
  }
}

class ErrorState implements PageState {
  final String message;

  const ErrorState(this.message);

  @override
  Widget getWidget() {
    return Center(
      child: Text(message),
    );
  }
}

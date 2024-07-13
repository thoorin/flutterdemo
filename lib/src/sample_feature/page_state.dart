import 'package:flutter/material.dart';
import 'package:flutter_demo/src/sample_feature/post.dart';

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

class LoadedState implements PageState {
  final List<Post> posts;

  LoadedState({required this.posts});

  @override
  Widget getWidget() {
    return ListView.builder(
      restorationId: 'postsView',
      itemCount: posts.length,
      itemBuilder: (BuildContext context, int index) {
        final post = posts[index];

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                'From: ${post.username}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                post.body,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ErrorState implements PageState {
  @override
  Widget getWidget() {
    return const Center(
      child: Text('Error loading posts'),
    );
  }
}

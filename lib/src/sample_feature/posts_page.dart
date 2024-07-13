import 'package:flutter/material.dart';
import 'package:flutter_demo/src/sample_feature/dto/post_dto.dart';
import 'package:flutter_demo/src/sample_feature/dto/user_dto.dart';
import 'package:flutter_demo/src/sample_feature/page_state.dart';
import 'package:flutter_demo/src/sample_feature/post.dart';
import 'package:flutter_demo/src/sample_feature/requests.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({
    super.key,
  });

  static const routeName = '/';

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  PageState pageState = LoadingState();
  bool isInitialized = false;

  List<Post> _buildPosts(List<PostDto> postsDto, List<UserDto> usersDto) {
    return postsDto.map((postDto) {
      final userDto =
          usersDto.firstWhere((userDto) => userDto.id == postDto.userId);

      return Post(
        id: postDto.id,
        title: postDto.title,
        body: postDto.body,
        username: userDto.username,
      );
    }).toList();
  }

  void _loadPosts() async {
    try {
      RequestResult<List<PostDto>> getPostsResult = await Requests.getPosts();
      RequestResult<List<UserDto>> getUsersResult = await Requests.getUsers();

      List<Post> posts =
          _buildPosts(getPostsResult.data ?? [], getUsersResult.data ?? []);

      if (getPostsResult.statusCode != 200 ||
          getUsersResult.statusCode != 200) {
        throw Error();
      }

      setState(() {
        pageState = LoadedState(posts: posts);
      });
    } catch (_) {
      setState(() {
        pageState = ErrorState();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isInitialized) {
      isInitialized = true;
      _loadPosts();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: pageState.getWidget(),
    );
  }
}

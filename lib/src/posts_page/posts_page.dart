import 'package:flutter/material.dart';
import 'package:flutter_demo/src/api/dto/post_dto.dart';
import 'package:flutter_demo/src/api/dto/user_dto.dart';
import 'package:flutter_demo/src/api/requests.dart';
import 'package:flutter_demo/src/main_navigation_bar.dart';
import 'package:flutter_demo/src/page_state.dart';
import 'package:flutter_demo/src/posts_page/post.dart';

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
  int selectedIndex = 0;

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
        pageState = LoadedPostsState(posts: posts);
      });
    } catch (_) {
      setState(() {
        pageState = const ErrorState("Error loading posts.");
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
      bottomNavigationBar: const MainNavigationBar(),
      appBar: AppBar(
        title: const Text('Posts'),
        automaticallyImplyLeading: false,
      ),
      body: pageState.getWidget(),
    );
  }
}

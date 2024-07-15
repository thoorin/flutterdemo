import 'dart:convert';

import 'package:flutter_demo/src/api/dto/comment_dto.dart';
import 'package:flutter_demo/src/api/dto/dto.dart';
import 'package:flutter_demo/src/api/dto/post_dto.dart';
import 'package:flutter_demo/src/api/dto/send_comment_dto.dart';
import 'package:flutter_demo/src/api/dto/user_dto.dart';
import 'package:http/http.dart';

typedef RequestResult<T> = ({int statusCode, T? data});
typedef CollectionResult<Dto> = Future<RequestResult<List<Dto>>>;

abstract class Requests {
  static CollectionResult<PostDto> getPosts() =>
      _Requests._getCollection('posts', PostDto.fromJson);

  static CollectionResult<UserDto> getUsers() =>
      _Requests._getCollection('users', UserDto.fromJson);

  static CollectionResult<CommentDto> getComments(int postId) =>
      _Requests._getCollection('posts/$postId/comments', CommentDto.fromJson);

  static Future<RequestResult> postComment(SendCommentDto comment) =>
      _Requests._postDocument('posts', comment);
}

abstract class _Requests {
  static const String apiAddress = 'https://jsonplaceholder.typicode.com/';

  static Future<RequestResult<Dto>> _getDocument<Dto>(
      String path, Function factory) async {
    RequestResult result = await _get(path);

    return (statusCode: result.statusCode, data: factory(result.data) as Dto);
  }

  static CollectionResult<Dto> _getCollection<Dto>(
      String path, Function factory) async {
    RequestResult result = await _get(path);

    return (
      statusCode: result.statusCode,
      data: List<Dto>.from(
        result.data.map(
          (model) => factory(model),
        ),
      ),
    );
  }

  static Future<RequestResult> _postDocument(String path, Dto body) async {
    return await _post(path, body);
  }

  static Future<RequestResult> _get(String path) async {
    Response response = await get(Uri.parse(apiAddress + path));
    final data = json.decode(response.body);

    return (statusCode: response.statusCode, data: data);
  }

  static Future<RequestResult> _post(String path, Dto body) async {
    Response response =
        await post(Uri.parse(apiAddress + path), body: body.toJson());
    final data = json.decode(response.body);

    return (statusCode: response.statusCode, data: data);
  }
}

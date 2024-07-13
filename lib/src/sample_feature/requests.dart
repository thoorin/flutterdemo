import 'dart:convert';

import 'package:flutter_demo/src/sample_feature/dto/post_dto.dart';
import 'package:flutter_demo/src/sample_feature/dto/user_dto.dart';
import 'package:http/http.dart';

typedef RequestResult<T> = ({int statusCode, T? data});
typedef CollectionResult<Dto> = Future<RequestResult<List<Dto>>>;

abstract class Requests {
  static CollectionResult<PostDto> getPosts() =>
      _Requests._getCollection('posts', PostDto.fromJson);

  static CollectionResult<UserDto> getUsers() =>
      _Requests._getCollection('users', UserDto.fromJson);

  static Future<RequestResult<PostDto>> getPost() =>
      _Requests._getDocument('posts/1', PostDto.fromJson);
}

abstract class _Requests {
  static const String apiAddress = 'https://jsonplaceholder.typicode.com/';

  static Future<RequestResult<Dto>> _getDocument<Dto>(
      String path, Function factory) async {
    RequestResult result = await _call(path);

    return (statusCode: result.statusCode, data: factory(result.data) as Dto);
  }

  static CollectionResult<Dto> _getCollection<Dto>(
      String path, Function factory) async {
    RequestResult result = await _call(path);

    return (
      statusCode: result.statusCode,
      data: List<Dto>.from(
        result.data.map(
          (model) => factory(model),
        ),
      ),
    );
  }

  static Future<RequestResult> _call(String path) async {
    Response response = await get(Uri.parse(apiAddress + path));
    final data = json.decode(response.body);

    return (statusCode: response.statusCode, data: data);
  }
}

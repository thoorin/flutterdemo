import 'package:flutter/material.dart';
import 'package:flutter_demo/src/api/dto/photo_dto.dart';
import 'package:flutter_demo/src/api/requests.dart';
import 'package:flutter_demo/src/main_navigation_bar.dart';
import 'package:flutter_demo/src/page_state.dart';

class AlbumDetailPage extends StatefulWidget {
  const AlbumDetailPage({
    super.key,
    required this.arguments,
  });

  static const routeName = '/album_detail';
  final ({int albumId, String albumTitle}) arguments;

  @override
  State<AlbumDetailPage> createState() => _AlbumDetailPageState();
}

class _AlbumDetailPageState extends State<AlbumDetailPage> {
  PageState pageState = LoadingState();
  bool isInitialized = false;

  void _loadPhotos() async {
    try {
      // userId is hardcoded to 1 for demo purposes
      // otherwise, this would probably be auth user's id
      RequestResult<List<PhotoDto>> getPhotosResult =
          await Requests.getAlbumPhotos(widget.arguments.albumId);

      if (getPhotosResult.statusCode != 200) {
        throw Error();
      }

      setState(() {
        pageState = LoadedPhotosState(getPhotosResult.data ?? []);
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
      _loadPhotos();
    }

    return Scaffold(
      bottomNavigationBar: const MainNavigationBar(),
      appBar: AppBar(
        title: Text(widget.arguments.albumTitle),
      ),
      body: pageState.getWidget(),
    );
  }
}

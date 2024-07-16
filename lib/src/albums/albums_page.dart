import 'package:flutter/material.dart';
import 'package:flutter_demo/src/api/dto/album_dto.dart';
import 'package:flutter_demo/src/api/requests.dart';
import 'package:flutter_demo/src/main_navigation_bar.dart';
import 'package:flutter_demo/src/page_state.dart';

class AlbumsPage extends StatefulWidget {
  const AlbumsPage({
    super.key,
  });

  static const routeName = '/albums';

  @override
  State<AlbumsPage> createState() => _AlbumsPageState();
}

class _AlbumsPageState extends State<AlbumsPage> {
  PageState pageState = LoadingState();
  bool isInitialized = false;

  void _loadAlbums() async {
    try {
      // userId is hardcoded to 1 for demo purposes
      // otherwise, this would probably be auth user's id
      RequestResult<List<AlbumDto>> getAlbumsResult =
          await Requests.getAlbums(1);

      if (getAlbumsResult.statusCode != 200) {
        throw Error();
      }

      setState(() {
        pageState = LoadedAlbumsState(getAlbumsResult.data ?? []);
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
      _loadAlbums();
    }

    return Scaffold(
      bottomNavigationBar: const MainNavigationBar(),
      appBar: AppBar(
        title: const Text('Albums'),
        automaticallyImplyLeading: false,
      ),
      body: pageState.getWidget(),
    );
  }
}

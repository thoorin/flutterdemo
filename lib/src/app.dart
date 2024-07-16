import 'package:flutter/material.dart';
import 'package:flutter_demo/src/album_detail_page/album_detail_page.dart';
import 'package:flutter_demo/src/albums/albums_page.dart';
import 'package:flutter_demo/src/posts_page/post.dart';

import 'post_detail_page/post_detail_page.dart';
import 'posts_page/posts_page.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'app',
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            switch (routeSettings.name) {
              case PostDetailPage.routeName:
                return PostDetailPage(
                  post: routeSettings.arguments as Post,
                );
              case AlbumsPage.routeName:
                return const AlbumsPage();
              case AlbumDetailPage.routeName:
                return AlbumDetailPage(
                  arguments: routeSettings.arguments as ({
                    int albumId,
                    String albumTitle
                  }),
                );
              case PostsPage.routeName || _:
                return const PostsPage();
            }
          },
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_demo/src/albums/albums_page.dart';
import 'package:flutter_demo/src/posts_page/posts_page.dart';

class MainNavigationBar extends StatelessWidget {
  static int selectedIndex = 0;

  const MainNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.comment),
          label: 'Posts',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.photo),
          label: 'Albums',
        ),
      ],
      onTap: (int index) {
        selectedIndex = index;
        Navigator.pushNamed(
          context,
          switch (index) {
            0 => PostsPage.routeName,
            1 || _ => AlbumsPage.routeName,
          },
        );
      },
    );
  }
}

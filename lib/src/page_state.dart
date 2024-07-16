import 'package:flutter/material.dart';
import 'package:flutter_demo/src/album_detail_page/album_detail_page.dart';
import 'package:flutter_demo/src/api/dto/album_dto.dart';
import 'package:flutter_demo/src/api/dto/comment_dto.dart';
import 'package:flutter_demo/src/api/dto/photo_dto.dart';
import 'package:flutter_demo/src/post_detail_page/comment_row.dart';
import 'package:flutter_demo/src/post_detail_page/post_detail_page.dart';
import 'package:flutter_demo/src/posts_page/post.dart';
import 'package:flutter_demo/src/posts_page/post_row.dart';
import 'package:flutter_demo/src/text_sizes.dart';

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

class LoadedAlbumsState implements PageState {
  final List<AlbumDto> albums;

  const LoadedAlbumsState(this.albums);

  @override
  Widget getWidget() {
    return ListView.builder(
      restorationId: 'albumsView',
      itemCount: albums.length,
      itemBuilder: (BuildContext context, int index) {
        final album = albums[index];

        return ListTile(
          onTap: () {
            Navigator.of(context).pushNamed(
              AlbumDetailPage.routeName,
              arguments: (albumId: album.id, albumTitle: album.title),
            );
          },
          title: Text(
            album.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: TextSizes.large,
            ),
          ),
        );
      },
    );
  }
}

class LoadedPhotosState implements PageState {
  final List<PhotoDto> photos;

  const LoadedPhotosState(this.photos);

  @override
  Widget getWidget() {
    return GridView.builder(
      restorationId: 'photosView',
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: photos.length,
      itemBuilder: (BuildContext context, int index) {
        final photo = photos[index];

        return Image.network(
          photo.thumbnailUrl,
          frameBuilder: (_, image, loadingBuilder, __) {
            if (loadingBuilder == null) {
              return const SizedBox(
                height: 300,
                child: Center(child: CircularProgressIndicator()),
              );
            }
            return image;
          },
          loadingBuilder: (context, image, loadingProgress) {
            if (loadingProgress == null) return image;
            return SizedBox(
              height: 300,
              child: Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              ),
            );
          },
          errorBuilder: (_, __, ___) =>
              const Center(child: Text('Image loading failed.')),
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

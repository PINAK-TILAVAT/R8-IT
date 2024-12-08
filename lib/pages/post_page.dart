import 'package:flutter/material.dart';
import 'package:r8_it/components/my_post_tile.dart';
import 'package:r8_it/helper/navigate_pages.dart';
import 'package:r8_it/models/post.dart';

class PostPage extends StatefulWidget {
  final Post post;
  const PostPage({super.key, required this.post});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text("Review Convo."),
      ),
      body: ListView(
        children: [
          MyPostTile(
              post: widget.post,
              onUserTap: () => goUserPage(context, widget.post.uid),
              onPostTap: () {}),
        ],
      ),
    );
  }
}

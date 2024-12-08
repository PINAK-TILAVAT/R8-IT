import 'package:flutter/material.dart';
import 'package:r8_it/models/post.dart';
import 'package:r8_it/pages/post_page.dart';
import 'package:r8_it/pages/profile_page.dart';

void goUserPage(BuildContext context, String uid) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => ProfilePage(uid: uid)));
}

void goPostPage(BuildContext context, Post post) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PostPage(
                post: post,
              )));
}

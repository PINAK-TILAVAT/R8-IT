import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:r8_it/helper/time.dart';
import 'package:r8_it/models/post.dart';
import 'package:r8_it/sevices/auth/auth_serviec.dart';

import 'package:r8_it/sevices/database/database_provider.dart';

class MyPostTile extends StatefulWidget {
  final Post post;
  final void Function()? onUserTap;
  final void Function()? onPostTap;
  const MyPostTile(
      {super.key,
      required this.post,
      required this.onUserTap,
      required this.onPostTap});

  @override
  State<MyPostTile> createState() => _MyPostTileState();
}

class _MyPostTileState extends State<MyPostTile> {
  late final listeningProvider = Provider.of<DatabaseProvider>(context);
  late final databaseProvider =
      Provider.of<DatabaseProvider>(context, listen: false);

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _loadComments();
  // }

  void _toggleLikePost() async {
    try {
      await databaseProvider.togglelike(widget.post.id);
    } catch (e) {}
  }

  // final _commentController = TextEditingController();

  // void _openNewCommentBox() {
  //   showDialog(
  //       context: context,
  //       builder: (context) => MyInputAlertBox(
  //           textController: _commentController,
  //           hintText: "Type a Comment....",
  //           onPressed: () async {
  //             await _addComment();
  //             await _loadComments();
  //           },
  //           onPressedText: "Post"));
  // }

  // Future<void> _addComment() async {
  //   if (_commentController.text.trim().isEmpty) return;

  //   try {
  //     await databaseProvider.addComments(
  //         widget.post.id, _commentController.text.trim());
  //   } catch (e) {}
  // }

  // Future<void> _loadComments() async {
  //   await databaseProvider.loadComments(widget.post.id);
  // }

  void _showOption() {
    String currentUid = AuthServiec().getCurrentUid();
    final bool isOwnPost = widget.post.uid == currentUid;
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
            child: Wrap(
              children: [
                if (isOwnPost) ...[
                  ListTile(
                    leading: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    title: Text("Delete"),
                    onTap: () async {
                      Navigator.pop(context);
                      await databaseProvider.deletePost(widget.post.id);
                    },
                  ),
                ] else ...[
                  ListTile(
                    leading: Icon(Icons.flag),
                    title: Text("Report"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.block),
                    title: Text("block User"),
                    onTap: () {},
                  ),
                ],
                ListTile(
                  leading: Icon(Icons.cancel),
                  title: Text("cancle"),
                  onTap: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    bool likedByCurrentUser =
        listeningProvider.isPostLikedByCurrentUser(widget.post.id);

    int likeCount = listeningProvider.getLikeCount(widget.post.id);
    // int commentCount = listeningProvider.getCommetns(widget.post.id).length;
    return GestureDetector(
      onTap: widget.onPostTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: widget.onUserTap,
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.post.name,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('@${widget.post.username}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      )),
                  Spacer(),
                  GestureDetector(
                      onTap: _showOption,
                      child: Icon(
                        Icons.more_horiz,
                        color: Theme.of(context).colorScheme.primary,
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(widget.post.message,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                )),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                GestureDetector(
                    onTap: _toggleLikePost,
                    child: likedByCurrentUser
                        ? Icon(
                            Icons.favorite,
                            color: Colors.pink,
                          )
                        : Icon(
                            Icons.favorite_border_outlined,
                            color: Theme.of(context).colorScheme.primary,
                          )),
                SizedBox(
                  width: 5,
                ),
                Text(
                  likeCount.toString(),
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                SizedBox(
                  width: 20,
                ),
                // GestureDetector(
                //   onTap: _openNewCommentBox,
                //   child: Icon(
                //     Icons.comment,
                //     color: Theme.of(context).colorScheme.primary,
                //   ),
                // ),
                // SizedBox(
                //   width: 5,
                // ),
                // Text(
                //   commentCount.toString(),
                //   style:
                //       TextStyle(color: Theme.of(context).colorScheme.primary),
                // ),
                Spacer(),
                Text(
                  formatTimer(widget.post.timestamp),
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

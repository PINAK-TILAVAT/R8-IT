import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:r8_it/components/my_drawer.dart';
import 'package:r8_it/components/my_input_alert_box.dart';
import 'package:r8_it/components/my_post_tile.dart';
import 'package:r8_it/helper/navigate_pages.dart';
import 'package:r8_it/models/post.dart';
import 'package:r8_it/sevices/database/database_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final listeningProvider = Provider.of<DatabaseProvider>(context);
  late final databaseProvider =
      Provider.of<DatabaseProvider>(context, listen: false);

  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadAllPosts();
  }

  Future<void> loadAllPosts() async {
    await databaseProvider.loadAllPosts();
  }

  void _openPostMessageBox() {
    showDialog(
        context: context,
        builder: (context) => MyInputAlertBox(
            textController: _messageController,
            hintText: "Write A Review",
            onPressed: () async {
              await postMessage(_messageController.text);
            },
            onPressedText: "Post"));
  }

  Future<void> postMessage(String message) async {
    await databaseProvider.postMessage(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: MyDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("R E V I E W   W A L L"),
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openPostMessageBox,
        child: Icon(Icons.add),
      ),
      body: _buildPostList(listeningProvider.allPosts),
    );
  }

  Widget _buildPostList(List<Post> posts) {
    return posts.isEmpty
        ? Center(
            child: Text(
              'REAL TALK , REAL REVIEWS',
              style: TextStyle(
                  fontSize: 20, color: Theme.of(context).colorScheme.primary),
            ),
          )
        : ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];

              return MyPostTile(
                post: post,
                onUserTap: () => goUserPage(context, post.uid),
                onPostTap: () => goPostPage(context, post),
              );
            },
          );
  }
}

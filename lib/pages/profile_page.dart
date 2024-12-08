import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:r8_it/components/my_bio_box.dart';
import 'package:r8_it/components/my_input_alert_box.dart';
import 'package:r8_it/components/my_post_tile.dart';
import 'package:r8_it/helper/navigate_pages.dart';
import 'package:r8_it/models/user.dart';

import 'package:r8_it/sevices/auth/auth_serviec.dart';
import 'package:r8_it/sevices/database/database_provider.dart';

class ProfilePage extends StatefulWidget {
  final String uid;
  const ProfilePage({super.key, required this.uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final listeningProvider = Provider.of<DatabaseProvider>(context);
  late final databaseProvider =
      Provider.of<DatabaseProvider>(context, listen: false);

  UserProfile? user;
  String currentUserId = AuthServiec().getCurrentUid();

  final bioTextController = TextEditingController();

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    loadUser();
  }

  Future<void> loadUser() async {
    user = await databaseProvider.userProfile(widget.uid);

    setState(() {
      _isLoading = false;
    });
  }

  void _showEditBioBox() {
    showDialog(
        context: context,
        builder: (context) => MyInputAlertBox(
              textController: bioTextController,
              hintText: "Edit Bio",
              onPressed: saveBio,
              onPressedText: 'SAVE',
            ));
  }

  Future<void> saveBio() async {
    setState(() {
      _isLoading = true;
    });

    await databaseProvider.updateBio(bioTextController.text);
    await loadUser();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final allUserPosts = listeningProvider.filterUserPosts(widget.uid);

    return Scaffold(
      appBar: AppBar(
          title: Text(_isLoading ? "" : user!.name,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  letterSpacing: 4))),
      body: ListView(
        children: [
          Center(
            child: Text(_isLoading ? "" : '@${user!.username}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(25),
              ),
              padding: EdgeInsets.all(25),
              child: Icon(
                Icons.person,
                size: 72,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              children: [
                Text(
                  "bio",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                Spacer(),
                GestureDetector(
                    onTap: _showEditBioBox,
                    child: Icon(
                      Icons.settings,
                      color: Theme.of(context).colorScheme.primary,
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          MyBioBox(text: _isLoading ? '...' : user!.bio),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 25),
            child: Text(
              "POSTS",
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          allUserPosts.isEmpty
              ? Center(
                  child: Text("NO POST YET...."),
                )
              : ListView.builder(
                  itemCount: allUserPosts.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final post = allUserPosts[index];

                    return MyPostTile(
                      post: post,
                      onUserTap: () {},
                      onPostTap: () => goPostPage(context, post),
                    );
                  })
        ],
      ),
    );
  }
}

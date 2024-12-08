import 'package:flutter/material.dart';
import 'package:r8_it/models/user.dart';
import 'package:r8_it/pages/profile_page.dart';

class MyUserTile extends StatelessWidget {
  final UserProfile user;
  const MyUserTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text(
          user.name,
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        subtitle: Text('@${user.username}'),
        leading: Icon(
          Icons.person,
          color: Theme.of(context).colorScheme.primary,
        ),
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProfilePage(uid: user.uid))),
      ),
    );
  }
}

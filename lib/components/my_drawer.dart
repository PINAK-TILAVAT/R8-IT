import 'package:flutter/material.dart';
import 'package:r8_it/components/my_drawer_tile.dart';
import 'package:r8_it/pages/profile_page.dart';
import 'package:r8_it/pages/search_page.dart';
import 'package:r8_it/pages/settings_page.dart';
import 'package:r8_it/sevices/auth/auth_serviec.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  final _auth = AuthServiec();

  void logout() {
    _auth.logout();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Column(
          children: [
            Image.asset(
              "assets/img/logo.png",
              height: 200,
            ),
            Divider(
              indent: 25,
              endIndent: 25,
              color: Theme.of(context).colorScheme.secondary,
            ),
            MyDrawerTile(
                title: "H O M E",
                icon: Icons.home,
                onTap: () {
                  Navigator.pop(context);
                }),
            MyDrawerTile(
              title: "P R O F I L E",
              icon: Icons.person,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProfilePage(uid: _auth.getCurrentUid())));
              },
            ),
            MyDrawerTile(
              title: "S E T T I N G",
              icon: Icons.settings,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsPage()));
              },
            ),
            MyDrawerTile(
              title: "S E A R C H",
              icon: Icons.search,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchPage()));
              },
            ),
            const Spacer(),
            MyDrawerTile(
                title: "L O G O U T", icon: Icons.logout, onTap: logout)
          ],
        ),
      ),
    );
  }
}

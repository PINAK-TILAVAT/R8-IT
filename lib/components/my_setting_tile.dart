import 'package:flutter/material.dart';

class MySettingTile extends StatelessWidget {
  final String title;
  final Widget action;

  const MySettingTile({super.key, required this.title, required this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.only(left: 25, right: 25, top: 10),
        padding: EdgeInsets.all(25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18),
            ),
            action,
          ],
        ));
  }
}

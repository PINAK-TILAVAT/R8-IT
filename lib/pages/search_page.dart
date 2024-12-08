import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:r8_it/components/my_user_tile.dart';
import 'package:r8_it/sevices/database/database_provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final listeningProvider = Provider.of<DatabaseProvider>(context);
    final databaseProvider =
        Provider.of<DatabaseProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "Search Users 🔍",
              hintStyle:
                  TextStyle(color: Theme.of(context).colorScheme.primary),
              border: InputBorder.none,
            ),
            onChanged: (value) {
              if (value.isEmpty) {
                databaseProvider.searchUsers(value);
              } else {
                databaseProvider.searchUsers("");
              }
            },
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: listeningProvider.searchResults.isEmpty
            ? Center(
                child: Text("No Users Found"),
              )
            : ListView.builder(
                itemCount: listeningProvider.searchResults.length,
                itemBuilder: (context, index) {
                  final user = listeningProvider.searchResults[index];

                  return MyUserTile(user: user);
                }));
  }
}

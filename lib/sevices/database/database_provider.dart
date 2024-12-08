import 'package:flutter/material.dart';
import 'package:r8_it/models/comment.dart';
import 'package:r8_it/models/post.dart';
import 'package:r8_it/models/user.dart';
import 'package:r8_it/sevices/auth/auth_serviec.dart';

import 'package:r8_it/sevices/database/database_service.dart';

class DatabaseProvider extends ChangeNotifier {
  final _auth = AuthServiec();
  final _db = DatabaseService();

  Future<UserProfile?> userProfile(String uid) => _db.getUserFromFireBase(uid);

  Future<void> updateBio(String bio) => _db.updateUserBioInFirebase(bio);

  List<Post> _allPosts = [];

  List<Post> get allPosts => _allPosts;

  Future<void> postMessage(String message) async {
    await _db.postMessageInFirebase(message);
    await loadAllPosts();
  }

  Future<void> loadAllPosts() async {
    final allPosts = await _db.getAllPostsFromFirebase();
    _allPosts = allPosts;
    initializeLikeMap();
    notifyListeners();
  }

  List<Post> filterUserPosts(String uid) {
    return _allPosts.where((post) => post.uid == uid).toList();
  }

  Future<void> deletePost(String postId) async {
    await _db.deletePostFromFirebase(postId);
    await loadAllPosts();
  }

  Map<String, int> _likeCounts = {};

  List<String> _likedPosts = [];

  bool isPostLikedByCurrentUser(String postId) => _likedPosts.contains(postId);
  int getLikeCount(String postId) => _likeCounts[postId] ?? 0;

  void initializeLikeMap() {
    final currentUserId = _auth.getCurrentUid();
    _likedPosts.clear();
    for (var post in _allPosts) {
      _likeCounts[post.id] = post.likeCount;

      if (post.likedBy.contains(currentUserId)) {
        _likedPosts.add(post.id);
      }
    }
  }

  Future<void> togglelike(String postId) async {
    final likedPostOriginal = _likedPosts;
    final likeCountsOriginal = _likeCounts;
    if (_likedPosts.contains(postId)) {
      _likedPosts.remove((postId));
      _likeCounts[postId] = (_likeCounts[postId] ?? 0) - 1;
    } else {
      _likedPosts.add(postId);
      _likeCounts[postId] = (_likeCounts[postId] ?? 0) + 1;
    }
    notifyListeners();

    try {
      await _db.toggleLikeInFirebase(postId);
    } catch (e) {
      _likedPosts = likedPostOriginal;
      _likeCounts = likeCountsOriginal;
    }
    notifyListeners();
  }

  List<UserProfile> _searchResults = [];
  List<UserProfile> get searchResults => _searchResults;

  final Map<String, List<Comment>> _comments = {};

  List<Comment> getCommetns(String postId) => _comments[postId] ?? [];

  Future<void> loadComments(String postId) async {
    final allComments = await _db.getCommentFromFirebase(postId);

    _comments[postId] = allComments;
    notifyListeners();
  }

  Future<void> addComments(String postId, message) async {
    await _db.addCommentInFirebase(postId, message);
    await loadComments(postId);
  }

  Future<void> deleteComment(String commentId, postId) async {
    await _db.deleteCommentInFirebase(commentId);
    await loadAllPosts();
  }

  Future<void> searchUsers(String searchTerm) async {
    try {
      final results = await _db.searchUserInFireBase(searchTerm);
      _searchResults = results;
      notifyListeners();
    } catch (e) {}
  }
}

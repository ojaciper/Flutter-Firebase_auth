import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter_clone/screens/add_post.dart';
import 'package:instagram_flutter_clone/screens/feed_screen.dart';
import 'package:instagram_flutter_clone/screens/profile_screen.dart';
import 'package:instagram_flutter_clone/screens/search_screen.dart';

const webScreenSize = 600;
const mobileScreenSize = 200;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const Text("Favorite"),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  )
];

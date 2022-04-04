import 'package:flutter/material.dart';
import 'package:instagram_flutter_clone/screens/add_post.dart';
import 'package:instagram_flutter_clone/screens/feed_screen.dart';

const webScreenSize = 600;
const mobileScreenSize = 200;

const homeScreenItems = [
  FeedScreen(),
  Text("Search"),
  AddPostScreen(),
  Text("Favorite"),
  Text("Profile")
];

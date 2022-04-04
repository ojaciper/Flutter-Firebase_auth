import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String? description;
  final String? uid;
  final String? username;
  final String? postId;
  final DateTime? datePublished;
  final String? postUrl;
  final String? profImage;
  final likes;

  Post({
    this.description,
    this.uid,
    this.username,
    this.postId,
    this.datePublished,
    this.postUrl,
    this.profImage,
    this.likes,
  });

// sending data to firebase
  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "username": username,
        "postId": postId,
        "datePublished": datePublished,
        "postUrl": postUrl,
        "profImage": profImage,
        "likes": likes
      };
// receiving data from firebase
  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
        description: snapshot["description"],
        uid: snapshot["uid"],
        username: snapshot["username"],
        postId: snapshot["postId"],
        datePublished: snapshot["datePublished"],
        postUrl: snapshot["postUrl"],
        profImage: snapshot["profImage"],
        likes: snapshot["likes"]);
  }
}

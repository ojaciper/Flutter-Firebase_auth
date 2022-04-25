import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_flutter_clone/models/comment.dart';
import 'package:instagram_flutter_clone/models/post.dart';
import 'package:instagram_flutter_clone/resources/storage_method.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //creating  post
  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String profImage) async {
    String res = "some error occurred";

    try {
      String photoUrl =
          await StorageMethod().uploadImageToStorage("posts", file, true);
      String postId = const Uuid().v1();
      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profImage: profImage,
        likes: [],
      );
      _firestore.collection("posts").doc(postId).set(post.toJson());
      return res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  // liking of post
  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection("posts").doc(postId).update({
          "likes": FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection("posts").doc(postId).update({
          "likes": FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

// posting of comment
  Future<void> postComment(String postId, String text, String uid, String name,
      String profilePic) async {
    String commentId = const Uuid().v1();
    try {
      Comment comment = Comment(
        profilePic: profilePic,
        name: name,
        uid: uid,
        commentId: commentId,
        datePublished: DateTime.now(),
      );

      if (text.isNotEmpty) {
        // String commentId = const Uuid().v1();
        await _firestore
            .collection("posts")
            .doc(postId)
            .collection("comment")
            .doc(commentId)
            .set(comment.toJson());

        //     {
        //   'profilePic': profilePic,
        //   'name': name,
        //   'uid': uid,
        //   'commentId': commentId,
        //   'datePublished': DateTime.now()
        // }
      } else {
        print('Text is empty');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //deleting post
  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection("posts").doc(postId).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  // follow user function

  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection("users").doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];
      if (following.contains(followId)) {
        await _firestore.collection('users').doc(followId).update({
          "following": FieldValue.arrayRemove([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          "following": FieldValue.arrayRemove([followId])
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          "following": FieldValue.arrayUnion([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          "following": FieldValue.arrayUnion([followId])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String? profilePic;
  String? name;
  String? uid;
  String? commentId;
  DateTime? datePublished;

  Comment({
    this.profilePic,
    this.name,
    this.uid,
    this.commentId,
    this.datePublished,
  });

  // sending data to firebase

  Map<String, dynamic> toJson() => {
        "profiPic": profilePic,
        "name": name,
        "uid": uid,
        "commentId": commentId,
        "datePublished": datePublished
      };

// receiveing data from firebase

  static Comment fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Comment(
      profilePic: snapshot["profilePic"],
      name: snapshot["name"],
      uid: snapshot["uid"],
      commentId: snapshot["commentId"],
      datePublished: snapshot["datePublished"],
    );
  }
}

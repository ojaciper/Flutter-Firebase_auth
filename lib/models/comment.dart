class Comment {
  String? profiPic;
  String? name;
  String? uid;
  String? commentId;
  DateTime? datePublished;

  Comment({
    this.profiPic,
    this.name,
    this.uid,
    this.commentId,
    this.datePublished,
  });

  // sending data to firebase

  Map<String, dynamic> toJson() => {
        "profiPic": profiPic,
        "name": name,
        "uid": uid,
        "commentId": commentId,
        "datePublished": datePublished
      };
}

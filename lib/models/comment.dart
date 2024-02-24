import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String username;
  String comment;
  final datePublished;
  List likes;
  String profilePhoto;
  String uid;
  String id;


  Comment({
    required this.uid,
    required this.likes,
    required this.username,
    required this.datePublished,
    required this.profilePhoto,
    required this.id,
    required this.comment,
  });

  Map<String, dynamic> toJson() =>
      {
        'username': username,
        'comment': comment,
        'datePublished': datePublished,
        'likes': likes,
        'profilePhoto': profilePhoto,
        'uid': uid,
        'id': id,

      };

  static Comment fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Comment(
        uid: snapshot['uid'],
        likes: snapshot['likes'],
        username: snapshot['username'],
        datePublished: snapshot['datePublished'],
        profilePhoto: snapshot['profilePhoto'],
        id: snapshot['id'],
        comment: snapshot['comment']
    );
  }

}
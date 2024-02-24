
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:peo_veo/constants/constant.dart';
import 'package:peo_veo/models/comment.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CommentController extends GetxController {
  final Rx<List<Comment>> _comments = Rx<List<Comment>>([]);

  List<Comment> get comments => _comments.value;

  String _postId = "";

  updatePostId(String id) {
    _postId = id;
    getComment();
  }

  getComment() async {
    _comments.bindStream(
      fireStore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .snapshots()
          .map((QuerySnapshot query) {
        List<Comment> retValue = [];
        for (var element in query.docs) {
          retValue.add(Comment.fromSnap(element));
        }
        return retValue;
      }),
    );
  }

  postComment(String commentText) async {
    try {
      if (commentText.isNotEmpty) {
        DocumentSnapshot userDoc = await fireStore
            .collection('users')
            .doc(authController.user.uid)
            .get();
        var allDocs = await fireStore
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .get();
        int len = allDocs.docs.length;
        Comment comment = Comment(
          uid: authController.user.uid,
          username: (userDoc.data()! as dynamic)['name'],
          likes: [],
          datePublished: DateTime.now(),
          profilePhoto: (userDoc.data()! as dynamic)['profilePhoto'],
          id: 'Comment $len',
          comment: commentText.trim(),
        );
        await fireStore
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .doc('comment $len')
            .set(comment.toJson());
        DocumentSnapshot doc =
            await fireStore.collection('videos').doc(_postId).get();
        await fireStore.collection('videos').doc(_postId).update({
          'commentCount': (doc.data()! as dynamic)['commentCount'] + 1,
        });
      }
    } catch (e) {
      Get.snackbar('Error While Commenting', e.toString());
    }
  }

  likeComment(String id) async
  {
    var uid = authController.user.uid;
    DocumentSnapshot doc = await fireStore.collection('videos').doc(_postId).collection('comments').doc(id).get() ;

    if(doc.data() == null)
      {
        print('nahi aaya');
      }

    try {
      if( (doc.data()! as dynamic)['likes'].contains(uid)  )
      {
        await fireStore.collection('videos').doc(_postId).collection('comments').doc(id).update({
          'likes' : FieldValue.arrayRemove([uid]),
        });
      }
      else
      {
        await fireStore.collection('vidoes').doc(_postId).collection('comments').doc(id).update({
          'likes' : FieldValue.arrayUnion([uid]),
        });
      }
    }
    catch (e) {
      Get.snackbar('Error While Liking', e.toString());
    }

  }

}


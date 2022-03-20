// Automatic FlutterFlow imports
import '../../backend/backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

// Begin custom action code
Future deleteComments(
  PostCommentsRecord comment,
  UserPostsRecord post,
) async {
  // get replies
  var repliesSnap = await FirebaseFirestore.instance
      .collection('commentReplies')
      .where('commentRef', isEqualTo: comment.reference)
      .get();

  // there is a reply
  if (repliesSnap.docs.isNotEmpty) {
    repliesSnap.docs.forEach((replyPivot) {
      //FirebaseFirestore.instance.collection("followers").doc(element.id).delete();
      DocumentReference replyRef =
          replyPivot.data()['replyRef'] as DocumentReference;
      removeComments(replyRef, post);

      // delete replyPivot
      replyPivot.reference.delete();
    });
  }

  // get parent comment
  var parentCommentSnap = await FirebaseFirestore.instance
      .collection('commentReplies')
      .where('replyRef', isEqualTo: comment.reference)
      .get();

  // there is a parent comment
  if (parentCommentSnap.docs.isNotEmpty) {
    // decrement number of replies
    final updateData = {
      'numReplies': FieldValue.increment(-1),
    };
    parentCommentSnap.docs[0].reference.update(updateData);
  }

  // delete comment
  comment.reference.delete();

  // decrement
  final updateData = {
    'numComments': FieldValue.increment(-1),
  };
  post.reference.update(updateData);
}

void removeComments(DocumentReference commentRef, UserPostsRecord post) async {
  //var reply = await commentRef.get();

  var repliesSnap = await FirebaseFirestore.instance
      .collection('commentReplies')
      .where('commentRef', isEqualTo: commentRef)
      .get();

  if (repliesSnap.docs.isNotEmpty) {
    repliesSnap.docs.forEach((replyPivot) {
      DocumentReference replyRef =
          replyPivot.data()['replyRef'] as DocumentReference;
      removeComments(replyRef, post);

      // delete replyPivot
      replyPivot.reference.delete();
    });
  }

  // get parent comment
  var parentCommentSnap = await FirebaseFirestore.instance
      .collection('commentReplies')
      .where('replyRef', isEqualTo: commentRef)
      .get();

  // there is a parent comment
  if (parentCommentSnap.docs.isNotEmpty) {
    // decrement number of replies
    final updateData = {
      'numReplies': FieldValue.increment(-1),
    };
    parentCommentSnap.docs[0].reference.update(updateData);
  }

  // delete comment
  commentRef.delete();

  // decrement
  final updateData = {
    'numComments': FieldValue.increment(-1),
  };
  post.reference.update(updateData);
}

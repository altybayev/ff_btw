// Automatic FlutterFlow imports
import '../../backend/backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

// Begin custom action code
Future addToFollowersFeed(
  DocumentReference postRef,
  DocumentReference userRef,
) async {
  var followersSnap = await FirebaseFirestore.instance
      .collection('followers')
      .where('followingRef', isEqualTo: userRef)
      .get();

  if (followersSnap.docs.isNotEmpty) {
    // user has followers

    followersSnap.docs.forEach((follower) async {
      DocumentReference followerRef =
          follower.data()['followerRef'] as DocumentReference;

      // get connection
      var connectionSnap = await FirebaseFirestore.instance
          .collection('connections')
          .where('aRef', isEqualTo: followerRef)
          .where('bRef', isEqualTo: userRef)
          .get();

      int level = 0;

      if (connectionSnap.docs.isNotEmpty) {
        // there is a connection between two users
        var connection = connectionSnap.docs[0].data();
        level = connection['numLevel'] as int;
      }

      if (level > 25) {
        var newFeedData = {
          'postRef': postRef,
          'userRef': followerRef,
          'rank': level,
          'createdAt': FieldValue.serverTimestamp
        };

        var newFeed = FirebaseFirestore.instance.collection('feeds').doc();
        await newFeed.set(newFeedData);
      }
    });
  }
}

// Automatic FlutterFlow imports
import '../../backend/backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

// Begin custom action code
Future deleteFromFollowers(
  DocumentReference followingRef,
  DocumentReference followerRef,
) async {
  var snap = await FirebaseFirestore.instance
      .collection('followers')
      .where('followingRef', isEqualTo: followingRef)
      .where('followerRef', isEqualTo: followerRef)
      .get();

  snap.docs.forEach((element) {
    FirebaseFirestore.instance.collection("followers").doc(element.id).delete();
  });
}

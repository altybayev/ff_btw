// Automatic FlutterFlow imports
import '../../backend/backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

// Begin custom action code
Future unfollow(
  DocumentReference followingRef,
  DocumentReference followerRef,
) async {
  final updateData = {
    'following': FieldValue.arrayRemove([followingRef]),
    'following_count': FieldValue.increment(-1),
  };

  await followerRef.update(updateData);
}

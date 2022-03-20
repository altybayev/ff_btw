// Automatic FlutterFlow imports
import '../../backend/backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

// Begin custom action code
Future follow(
  DocumentReference followingRef,
  DocumentReference followerRef,
) async {
  final updateData = {
    'following': FieldValue.arrayUnion([followingRef]),
    'following_count': FieldValue.increment(1),
  };

  await followerRef.update(updateData);
}

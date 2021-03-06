import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import '../backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../auth/auth_util.dart';

int likes(UserPostsRecord post) {
  return post.likes.length;
}

bool hasUploadedMedia(String mediaPath) {
  return mediaPath != null && mediaPath.isNotEmpty;
}

bool isLikedByUser(
  UserPostsRecord post,
  DocumentReference userRef,
) {
  return post.likes.contains(userRef);
}

bool isCommentDislikedByUser(
  PostCommentsRecord comment,
  DocumentReference userRef,
) {
  return comment.dislikes.contains(userRef);
}

bool isCommentLikedByUser(
  PostCommentsRecord comment,
  DocumentReference userRef,
) {
  return comment.likes.contains(userRef);
}

bool isFollowedByUser(
  UsersRecord user,
  DocumentReference targetRef,
) {
  return user.followers.contains(targetRef);
}

bool isFollowingByUser(
  UsersRecord user,
  DocumentReference targetRef,
) {
  return user.following.contains(targetRef);
}

bool isFavoritedByUser(
  UserPostsRecord post,
  DocumentReference userRef,
) {
  return post.favorites.contains(userRef);
}

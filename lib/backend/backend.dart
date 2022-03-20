import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../flutter_flow/flutter_flow_util.dart';

import 'schema/user_posts_record.dart';
import 'schema/users_record.dart';
import 'schema/post_comments_record.dart';
import 'schema/user_stories_record.dart';
import 'schema/story_comments_record.dart';
import 'schema/dogs_record.dart';
import 'schema/friends_record.dart';
import 'schema/chats_record.dart';
import 'schema/chat_messages_record.dart';
import 'schema/categories_record.dart';
import 'schema/blocks_record.dart';
import 'schema/tags_record.dart';
import 'schema/followers_record.dart';
import 'schema/comment_replies_record.dart';
import 'schema/favorites_record.dart';
import 'schema/connections_record.dart';
import 'schema/feeds_record.dart';
import 'schema/serializers.dart';

export 'package:cloud_firestore/cloud_firestore.dart';
export 'schema/index.dart';
export 'schema/serializers.dart';

export 'schema/user_posts_record.dart';
export 'schema/users_record.dart';
export 'schema/post_comments_record.dart';
export 'schema/user_stories_record.dart';
export 'schema/story_comments_record.dart';
export 'schema/dogs_record.dart';
export 'schema/friends_record.dart';
export 'schema/chats_record.dart';
export 'schema/chat_messages_record.dart';
export 'schema/categories_record.dart';
export 'schema/blocks_record.dart';
export 'schema/tags_record.dart';
export 'schema/followers_record.dart';
export 'schema/comment_replies_record.dart';
export 'schema/favorites_record.dart';
export 'schema/connections_record.dart';
export 'schema/feeds_record.dart';

/// Functions to query UserPostsRecords (as a Stream and as a Future).
Stream<List<UserPostsRecord>> queryUserPostsRecord(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollection(UserPostsRecord.collection, UserPostsRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

Future<List<UserPostsRecord>> queryUserPostsRecordOnce(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollectionOnce(UserPostsRecord.collection, UserPostsRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

/// Functions to query UsersRecords (as a Stream and as a Future).
Stream<List<UsersRecord>> queryUsersRecord(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollection(UsersRecord.collection, UsersRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

Future<List<UsersRecord>> queryUsersRecordOnce(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollectionOnce(UsersRecord.collection, UsersRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

/// Functions to query PostCommentsRecords (as a Stream and as a Future).
Stream<List<PostCommentsRecord>> queryPostCommentsRecord(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollection(
        PostCommentsRecord.collection, PostCommentsRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

Future<List<PostCommentsRecord>> queryPostCommentsRecordOnce(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollectionOnce(
        PostCommentsRecord.collection, PostCommentsRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

/// Functions to query UserStoriesRecords (as a Stream and as a Future).
Stream<List<UserStoriesRecord>> queryUserStoriesRecord(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollection(UserStoriesRecord.collection, UserStoriesRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

Future<List<UserStoriesRecord>> queryUserStoriesRecordOnce(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollectionOnce(
        UserStoriesRecord.collection, UserStoriesRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

/// Functions to query StoryCommentsRecords (as a Stream and as a Future).
Stream<List<StoryCommentsRecord>> queryStoryCommentsRecord(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollection(
        StoryCommentsRecord.collection, StoryCommentsRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

Future<List<StoryCommentsRecord>> queryStoryCommentsRecordOnce(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollectionOnce(
        StoryCommentsRecord.collection, StoryCommentsRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

/// Functions to query DogsRecords (as a Stream and as a Future).
Stream<List<DogsRecord>> queryDogsRecord(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollection(DogsRecord.collection, DogsRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

Future<List<DogsRecord>> queryDogsRecordOnce(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollectionOnce(DogsRecord.collection, DogsRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

/// Functions to query FriendsRecords (as a Stream and as a Future).
Stream<List<FriendsRecord>> queryFriendsRecord(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollection(FriendsRecord.collection, FriendsRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

Future<List<FriendsRecord>> queryFriendsRecordOnce(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollectionOnce(FriendsRecord.collection, FriendsRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

/// Functions to query ChatsRecords (as a Stream and as a Future).
Stream<List<ChatsRecord>> queryChatsRecord(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollection(ChatsRecord.collection, ChatsRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

Future<List<ChatsRecord>> queryChatsRecordOnce(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollectionOnce(ChatsRecord.collection, ChatsRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

/// Functions to query ChatMessagesRecords (as a Stream and as a Future).
Stream<List<ChatMessagesRecord>> queryChatMessagesRecord(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollection(
        ChatMessagesRecord.collection, ChatMessagesRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

Future<List<ChatMessagesRecord>> queryChatMessagesRecordOnce(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollectionOnce(
        ChatMessagesRecord.collection, ChatMessagesRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

/// Functions to query CategoriesRecords (as a Stream and as a Future).
Stream<List<CategoriesRecord>> queryCategoriesRecord(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollection(CategoriesRecord.collection, CategoriesRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

Future<List<CategoriesRecord>> queryCategoriesRecordOnce(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollectionOnce(
        CategoriesRecord.collection, CategoriesRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

/// Functions to query BlocksRecords (as a Stream and as a Future).
Stream<List<BlocksRecord>> queryBlocksRecord(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollection(BlocksRecord.collection, BlocksRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

Future<List<BlocksRecord>> queryBlocksRecordOnce(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollectionOnce(BlocksRecord.collection, BlocksRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

/// Functions to query TagsRecords (as a Stream and as a Future).
Stream<List<TagsRecord>> queryTagsRecord(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollection(TagsRecord.collection, TagsRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

Future<List<TagsRecord>> queryTagsRecordOnce(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollectionOnce(TagsRecord.collection, TagsRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

/// Functions to query FollowersRecords (as a Stream and as a Future).
Stream<List<FollowersRecord>> queryFollowersRecord(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollection(FollowersRecord.collection, FollowersRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

Future<List<FollowersRecord>> queryFollowersRecordOnce(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollectionOnce(FollowersRecord.collection, FollowersRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

/// Functions to query CommentRepliesRecords (as a Stream and as a Future).
Stream<List<CommentRepliesRecord>> queryCommentRepliesRecord(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollection(
        CommentRepliesRecord.collection, CommentRepliesRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

Future<List<CommentRepliesRecord>> queryCommentRepliesRecordOnce(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollectionOnce(
        CommentRepliesRecord.collection, CommentRepliesRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

/// Functions to query FavoritesRecords (as a Stream and as a Future).
Stream<List<FavoritesRecord>> queryFavoritesRecord(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollection(FavoritesRecord.collection, FavoritesRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

Future<List<FavoritesRecord>> queryFavoritesRecordOnce(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollectionOnce(FavoritesRecord.collection, FavoritesRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

/// Functions to query ConnectionsRecords (as a Stream and as a Future).
Stream<List<ConnectionsRecord>> queryConnectionsRecord(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollection(ConnectionsRecord.collection, ConnectionsRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

Future<List<ConnectionsRecord>> queryConnectionsRecordOnce(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollectionOnce(
        ConnectionsRecord.collection, ConnectionsRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

/// Functions to query FeedsRecords (as a Stream and as a Future).
Stream<List<FeedsRecord>> queryFeedsRecord(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollection(FeedsRecord.collection, FeedsRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

Future<List<FeedsRecord>> queryFeedsRecordOnce(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollectionOnce(FeedsRecord.collection, FeedsRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

Stream<List<T>> queryCollection<T>(
    CollectionReference collection, Serializer<T> serializer,
    {Query Function(Query) queryBuilder,
    int limit = -1,
    bool singleRecord = false}) {
  final builder = queryBuilder ?? (q) => q;
  var query = builder(collection);
  if (limit > 0 || singleRecord) {
    query = query.limit(singleRecord ? 1 : limit);
  }
  return query.snapshots().map((s) => s.docs
      .map(
        (d) => safeGet(
          () => serializers.deserializeWith(serializer, serializedData(d)),
          (e) => print('Error serializing doc ${d.reference.path}:\n$e'),
        ),
      )
      .where((d) => d != null)
      .toList());
}

Future<List<T>> queryCollectionOnce<T>(
    CollectionReference collection, Serializer<T> serializer,
    {Query Function(Query) queryBuilder,
    int limit = -1,
    bool singleRecord = false}) {
  final builder = queryBuilder ?? (q) => q;
  var query = builder(collection);
  if (limit > 0 || singleRecord) {
    query = query.limit(singleRecord ? 1 : limit);
  }
  return query.get().then((s) => s.docs
      .map(
        (d) => safeGet(
          () => serializers.deserializeWith(serializer, serializedData(d)),
          (e) => print('Error serializing doc ${d.reference.path}:\n$e'),
        ),
      )
      .where((d) => d != null)
      .toList());
}

// Creates a Firestore record representing the logged in user if it doesn't yet exist
Future maybeCreateUser(User user) async {
  final userRecord = UsersRecord.collection.doc(user.uid);
  final userExists = await userRecord.get().then((u) => u.exists);
  if (userExists) {
    return;
  }

  final userData = createUsersRecordData(
    email: user.email,
    displayName: user.displayName,
    photoUrl: user.photoURL,
    uid: user.uid,
    phoneNumber: user.phoneNumber,
    createdTime: getCurrentTimestamp,
  );

  await userRecord.set(userData);
}

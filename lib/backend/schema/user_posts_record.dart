import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'user_posts_record.g.dart';

abstract class UserPostsRecord
    implements Built<UserPostsRecord, UserPostsRecordBuilder> {
  static Serializer<UserPostsRecord> get serializer =>
      _$userPostsRecordSerializer;

  @nullable
  String get postPhoto;

  @nullable
  String get postTitle;

  @nullable
  String get postDescription;

  @nullable
  DocumentReference get postUser;

  @nullable
  DateTime get timePosted;

  @nullable
  BuiltList<DocumentReference> get likes;

  @nullable
  int get numComments;

  @nullable
  bool get postOwner;

  @nullable
  int get numLikes;

  @nullable
  bool get isDraft;

  @nullable
  DocumentReference get category;

  @nullable
  BuiltList<String> get tags;

  @nullable
  String get categoryName;

  @nullable
  BuiltList<DocumentReference> get favorites;

  @nullable
  int get numFavorites;

  @nullable
  int get numViews;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(UserPostsRecordBuilder builder) => builder
    ..postPhoto = ''
    ..postTitle = ''
    ..postDescription = ''
    ..likes = ListBuilder()
    ..numComments = 0
    ..postOwner = false
    ..numLikes = 0
    ..isDraft = false
    ..tags = ListBuilder()
    ..categoryName = ''
    ..favorites = ListBuilder()
    ..numFavorites = 0
    ..numViews = 0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('userPosts');

  static Stream<UserPostsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<UserPostsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  UserPostsRecord._();
  factory UserPostsRecord([void Function(UserPostsRecordBuilder) updates]) =
      _$UserPostsRecord;

  static UserPostsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createUserPostsRecordData({
  String postPhoto,
  String postTitle,
  String postDescription,
  DocumentReference postUser,
  DateTime timePosted,
  int numComments,
  bool postOwner,
  int numLikes,
  bool isDraft,
  DocumentReference category,
  String categoryName,
  int numFavorites,
  int numViews,
}) =>
    serializers.toFirestore(
        UserPostsRecord.serializer,
        UserPostsRecord((u) => u
          ..postPhoto = postPhoto
          ..postTitle = postTitle
          ..postDescription = postDescription
          ..postUser = postUser
          ..timePosted = timePosted
          ..likes = null
          ..numComments = numComments
          ..postOwner = postOwner
          ..numLikes = numLikes
          ..isDraft = isDraft
          ..category = category
          ..tags = null
          ..categoryName = categoryName
          ..favorites = null
          ..numFavorites = numFavorites
          ..numViews = numViews));

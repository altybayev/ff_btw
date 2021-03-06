import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'users_record.g.dart';

abstract class UsersRecord implements Built<UsersRecord, UsersRecordBuilder> {
  static Serializer<UsersRecord> get serializer => _$usersRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'display_name')
  String get displayName;

  @nullable
  String get email;

  @nullable
  @BuiltValueField(wireName: 'photo_url')
  String get photoUrl;

  @nullable
  String get uid;

  @nullable
  @BuiltValueField(wireName: 'created_time')
  DateTime get createdTime;

  @nullable
  @BuiltValueField(wireName: 'phone_number')
  String get phoneNumber;

  @nullable
  String get userName;

  @nullable
  String get bio;

  @nullable
  bool get isFollowed;

  @nullable
  double get earnings;

  @nullable
  String get position;

  @nullable
  @BuiltValueField(wireName: 'followers_count')
  int get followersCount;

  @nullable
  @BuiltValueField(wireName: 'following_count')
  int get followingCount;

  @nullable
  @BuiltValueField(wireName: 'posts_count')
  int get postsCount;

  @nullable
  BuiltList<DocumentReference> get followers;

  @nullable
  BuiltList<DocumentReference> get following;

  @nullable
  double get numPoints;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(UsersRecordBuilder builder) => builder
    ..displayName = ''
    ..email = ''
    ..photoUrl = ''
    ..uid = ''
    ..phoneNumber = ''
    ..userName = ''
    ..bio = ''
    ..isFollowed = false
    ..earnings = 0.0
    ..position = ''
    ..followersCount = 0
    ..followingCount = 0
    ..postsCount = 0
    ..followers = ListBuilder()
    ..following = ListBuilder()
    ..numPoints = 0.0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  UsersRecord._();
  factory UsersRecord([void Function(UsersRecordBuilder) updates]) =
      _$UsersRecord;

  static UsersRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createUsersRecordData({
  String displayName,
  String email,
  String photoUrl,
  String uid,
  DateTime createdTime,
  String phoneNumber,
  String userName,
  String bio,
  bool isFollowed,
  double earnings,
  String position,
  int followersCount,
  int followingCount,
  int postsCount,
  double numPoints,
}) =>
    serializers.toFirestore(
        UsersRecord.serializer,
        UsersRecord((u) => u
          ..displayName = displayName
          ..email = email
          ..photoUrl = photoUrl
          ..uid = uid
          ..createdTime = createdTime
          ..phoneNumber = phoneNumber
          ..userName = userName
          ..bio = bio
          ..isFollowed = isFollowed
          ..earnings = earnings
          ..position = position
          ..followersCount = followersCount
          ..followingCount = followingCount
          ..postsCount = postsCount
          ..followers = null
          ..following = null
          ..numPoints = numPoints));

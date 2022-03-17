import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'followers_record.g.dart';

abstract class FollowersRecord
    implements Built<FollowersRecord, FollowersRecordBuilder> {
  static Serializer<FollowersRecord> get serializer =>
      _$followersRecordSerializer;

  @nullable
  DocumentReference get followerRef;

  @nullable
  DateTime get createdAt;

  @nullable
  DocumentReference get followingRef;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(FollowersRecordBuilder builder) => builder;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('followers');

  static Stream<FollowersRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<FollowersRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  FollowersRecord._();
  factory FollowersRecord([void Function(FollowersRecordBuilder) updates]) =
      _$FollowersRecord;

  static FollowersRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createFollowersRecordData({
  DocumentReference followerRef,
  DateTime createdAt,
  DocumentReference followingRef,
}) =>
    serializers.toFirestore(
        FollowersRecord.serializer,
        FollowersRecord((f) => f
          ..followerRef = followerRef
          ..createdAt = createdAt
          ..followingRef = followingRef));

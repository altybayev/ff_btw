import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'post_comments_record.g.dart';

abstract class PostCommentsRecord
    implements Built<PostCommentsRecord, PostCommentsRecordBuilder> {
  static Serializer<PostCommentsRecord> get serializer =>
      _$postCommentsRecordSerializer;

  @nullable
  DateTime get timePosted;

  @nullable
  String get comment;

  @nullable
  DocumentReference get user;

  @nullable
  DocumentReference get post;

  @nullable
  BuiltList<DocumentReference> get likes;

  @nullable
  BuiltList<DocumentReference> get dislikes;

  @nullable
  int get numLikes;

  @nullable
  int get numDislikes;

  @nullable
  int get numReplies;

  @nullable
  int get level;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(PostCommentsRecordBuilder builder) => builder
    ..comment = ''
    ..likes = ListBuilder()
    ..dislikes = ListBuilder()
    ..numLikes = 0
    ..numDislikes = 0
    ..numReplies = 0
    ..level = 0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('postComments');

  static Stream<PostCommentsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<PostCommentsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s)));

  PostCommentsRecord._();
  factory PostCommentsRecord(
          [void Function(PostCommentsRecordBuilder) updates]) =
      _$PostCommentsRecord;

  static PostCommentsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createPostCommentsRecordData({
  DateTime timePosted,
  String comment,
  DocumentReference user,
  DocumentReference post,
  int numLikes,
  int numDislikes,
  int numReplies,
  int level,
}) =>
    serializers.toFirestore(
        PostCommentsRecord.serializer,
        PostCommentsRecord((p) => p
          ..timePosted = timePosted
          ..comment = comment
          ..user = user
          ..post = post
          ..likes = null
          ..dislikes = null
          ..numLikes = numLikes
          ..numDislikes = numDislikes
          ..numReplies = numReplies
          ..level = level));

import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'comment_replies_record.g.dart';

abstract class CommentRepliesRecord
    implements Built<CommentRepliesRecord, CommentRepliesRecordBuilder> {
  static Serializer<CommentRepliesRecord> get serializer =>
      _$commentRepliesRecordSerializer;

  @nullable
  DateTime get createdAt;

  @nullable
  DocumentReference get commentRef;

  @nullable
  DocumentReference get replyRef;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(CommentRepliesRecordBuilder builder) =>
      builder;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('commentReplies');

  static Stream<CommentRepliesRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<CommentRepliesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s)));

  CommentRepliesRecord._();
  factory CommentRepliesRecord(
          [void Function(CommentRepliesRecordBuilder) updates]) =
      _$CommentRepliesRecord;

  static CommentRepliesRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createCommentRepliesRecordData({
  DateTime createdAt,
  DocumentReference commentRef,
  DocumentReference replyRef,
}) =>
    serializers.toFirestore(
        CommentRepliesRecord.serializer,
        CommentRepliesRecord((c) => c
          ..createdAt = createdAt
          ..commentRef = commentRef
          ..replyRef = replyRef));

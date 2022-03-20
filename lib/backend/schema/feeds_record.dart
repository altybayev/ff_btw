import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'feeds_record.g.dart';

abstract class FeedsRecord implements Built<FeedsRecord, FeedsRecordBuilder> {
  static Serializer<FeedsRecord> get serializer => _$feedsRecordSerializer;

  @nullable
  DocumentReference get userRef;

  @nullable
  DocumentReference get postRef;

  @nullable
  int get rank;

  @nullable
  DateTime get createdAt;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(FeedsRecordBuilder builder) =>
      builder..rank = 0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('feeds');

  static Stream<FeedsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<FeedsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  FeedsRecord._();
  factory FeedsRecord([void Function(FeedsRecordBuilder) updates]) =
      _$FeedsRecord;

  static FeedsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createFeedsRecordData({
  DocumentReference userRef,
  DocumentReference postRef,
  int rank,
  DateTime createdAt,
}) =>
    serializers.toFirestore(
        FeedsRecord.serializer,
        FeedsRecord((f) => f
          ..userRef = userRef
          ..postRef = postRef
          ..rank = rank
          ..createdAt = createdAt));

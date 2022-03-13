import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'blocks_record.g.dart';

abstract class BlocksRecord
    implements Built<BlocksRecord, BlocksRecordBuilder> {
  static Serializer<BlocksRecord> get serializer => _$blocksRecordSerializer;

  @nullable
  String get type;

  @nullable
  String get content;

  @nullable
  String get imageUrl;

  @nullable
  String get videoUrl;

  @nullable
  DocumentReference get postRef;

  @nullable
  DateTime get createdAt;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(BlocksRecordBuilder builder) => builder
    ..type = ''
    ..content = ''
    ..imageUrl = ''
    ..videoUrl = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('blocks');

  static Stream<BlocksRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<BlocksRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  BlocksRecord._();
  factory BlocksRecord([void Function(BlocksRecordBuilder) updates]) =
      _$BlocksRecord;

  static BlocksRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createBlocksRecordData({
  String type,
  String content,
  String imageUrl,
  String videoUrl,
  DocumentReference postRef,
  DateTime createdAt,
}) =>
    serializers.toFirestore(
        BlocksRecord.serializer,
        BlocksRecord((b) => b
          ..type = type
          ..content = content
          ..imageUrl = imageUrl
          ..videoUrl = videoUrl
          ..postRef = postRef
          ..createdAt = createdAt));

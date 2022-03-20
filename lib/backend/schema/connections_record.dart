import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'connections_record.g.dart';

abstract class ConnectionsRecord
    implements Built<ConnectionsRecord, ConnectionsRecordBuilder> {
  static Serializer<ConnectionsRecord> get serializer =>
      _$connectionsRecordSerializer;

  @nullable
  DocumentReference get aRef;

  @nullable
  DocumentReference get bRef;

  @nullable
  DateTime get createdAt;

  @nullable
  DateTime get updatedAt;

  @nullable
  int get numLevel;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(ConnectionsRecordBuilder builder) =>
      builder..numLevel = 0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('connections');

  static Stream<ConnectionsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<ConnectionsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  ConnectionsRecord._();
  factory ConnectionsRecord([void Function(ConnectionsRecordBuilder) updates]) =
      _$ConnectionsRecord;

  static ConnectionsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createConnectionsRecordData({
  DocumentReference aRef,
  DocumentReference bRef,
  DateTime createdAt,
  DateTime updatedAt,
  int numLevel,
}) =>
    serializers.toFirestore(
        ConnectionsRecord.serializer,
        ConnectionsRecord((c) => c
          ..aRef = aRef
          ..bRef = bRef
          ..createdAt = createdAt
          ..updatedAt = updatedAt
          ..numLevel = numLevel));

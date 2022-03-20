// Automatic FlutterFlow imports
import '../../backend/backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

// Begin custom action code
Future updateConnection(
  DocumentReference aRef,
  DocumentReference bRef,
  int numLevel,
) async {
  // if same user -> do nothing
  if (aRef == bRef) return;

  var connectionSnap = await FirebaseFirestore.instance
      .collection('connections')
      .where('aRef', isEqualTo: aRef)
      .where('bRef', isEqualTo: bRef)
      .get();

  if (connectionSnap.docs.isNotEmpty) {
    // connection is already have
    final updateData = {
      'numLevel': FieldValue.increment(numLevel),
      'updatedAt': FieldValue.serverTimestamp()
    };

    // update connection
    connectionSnap.docs[0].reference.update(updateData);

    return;
  }

  // first touch
  final connectionData = {
    'aRef': aRef,
    'bRef': bRef,
    'numLevel': 100, // for first touch!
    'createdAt': FieldValue.serverTimestamp()
  };

  var connectionReference =
      FirebaseFirestore.instance.collection('connections').doc();
  await connectionReference.set(connectionData);
}

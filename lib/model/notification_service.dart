import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'firestore_service.dart';

// Stream<QueryDocumentSnapshot> stream = Provider.of<FirestoreService>(context)
//     .users
//     .where('type', isEqualTo: 'Important')
//     .orderBy('timestamp', descending: true)
//     .snapshots()
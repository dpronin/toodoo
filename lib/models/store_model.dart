import 'package:cloud_firestore/cloud_firestore.dart';

class Store {
  final String documentID;
  String username = '';
  String title = '';
  Priority priority = Priority.low;

  Store(this.documentID);

  Map<String, dynamic> toSnapshot() {
    return {
      'documentID': documentID,
      'username': username,
      'title': title,
      'priority': priority.index
    };
  }

  Store.fromSnapshot(DocumentSnapshot snapshot)
      : documentID = snapshot.documentID,
        title = snapshot.data['title'] ?? '',
        priority = Priority.values[snapshot.data['priority'] ?? 0];
}

enum Priority { low, medium, high }

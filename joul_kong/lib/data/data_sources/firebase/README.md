# 🔥 Firebase Data Sources

This folder is dedicated to direct interactions with **Google Firebase services** (Firestore, Firebase Auth, Firebase Storage).

### 📄 Usage

Use this folder when you are using the official `firebase_core` and related plugins. These classes should transform Firebase snapshots into raw Maps or Models.

### 🚀 Example: `firestore_ds.dart`

```dart
import 'package:cloud_firestore/cloud_firestore.dart';

class UserFirestoreDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> getUserDoc(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    return doc.data();
  }
}

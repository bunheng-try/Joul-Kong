# 📦 Data Models & Communication Wrappers

This folder contains all the data blueprints for the application. To keep our code type-safe and predictable, we **never** pass raw JSON/Maps through the app. Instead, we use these three types of models to handle data and API states.

---

## 1️⃣ Domain Models (The Data Blueprints)

These are standard Dart classes representing your core entities (User, Product, etc.).

**Requirements:**

* **`fromJson`**: To parse data from APIs/Firebase.
* **`toJson`**: To send data back to servers.
* **`copyWith`**: To update specific fields without mutating the original object (crucial for state management).

**Example (`user_model.dart`):**

```dart
class UserModel {
  final String id;
  final String name;
  final String? email;

  UserModel({
    required this.id,
    required this.name,
    this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }

  UserModel copyWith({
    String? name,
    String? email,
  }) {
    return UserModel(
      id: id, 
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}

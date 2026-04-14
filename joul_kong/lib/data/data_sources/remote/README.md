# 🌐 Remote Data Sources

This folder is for **REST API communication**. If you are hitting a standard backend (Node.js, Python, PHP) via HTTP, the code goes here.

### 📄 Usage

Uses the `http` package or `Dio`. It should use the `ApiClient` defined in `lib/network/`.

### 🚀 Example: `user_remote_ds.dart`

```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserRemoteDataSource {
  final String baseUrl = "[https://api.example.com](https://api.example.com)";

  Future<Map<String, dynamic>> fetchProfile(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$userId'));
    
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load profile');
    }
  }
}

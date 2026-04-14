# 💾 Local Data Sources

This folder handles **on-device storage**. Use this for caching data so the app works offline or for saving user preferences (like "Dark Mode" or "Keep me logged in").

### 📄 Usage

Commonly uses packages like `shared_preferences`, `flutter_secure_storage`, or `hive`.

### 🚀 Example: `user_local_ds.dart`

```dart
import 'package:shared_preferences/shared_preferences.dart';

class UserLocalDataSource {
  static const _tokenKey = 'auth_token';

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }
}

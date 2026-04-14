# 🧠 State Management (Providers)

This folder contains the logic for managing the application's state using the `provider` package. This is where we handle user interactions, call repositories, and tell the UI to rebuild when data changes.

## 📄 What does a Provider do?

1. **Holds State**: Stores variables (like `currentUser` or `productList`) that the UI needs.
2. **Communicates with Repositories**: Triggers data fetching.
3. **Notifies UI**: Uses `notifyListeners()` to refresh the screen when data changes.
4. **Handles Logic**: Manages UI-specific logic (e.g., toggling a password visibility icon).

---

## 🚀 Detailed Code Example: `auth_provider.dart`

Every provider should extend `ChangeNotifier`. Here is how to implement a clean provider using the `ApiResponse` and `Repository` patterns we established.

```dart
import 'package:flutter/material.dart';
import '../data/models/user_model.dart';
import '../data/models/api_response.dart';
import '../data/repositories/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository repository;

  // Constructor: Inject the repository
  AuthProvider({required this.repository});

  // 1. STATE: Keep track of the login status
  ApiResponse<UserModel> _loginState = ApiResponse.loading(); 
  
  // 2. GETTER: Allow UI to read the state but not modify it directly
  ApiResponse<UserModel> get loginState => _loginState;

  // 3. ACTION: The function the UI calls
  Future<void> login(String email, String password) async {
    // Start loading
    _loginState = ApiResponse.loading();
    notifyListeners(); // Tell the UI to show a spinner

    try {
      // Call the repository (The "What" from our contract)
      final result = await repository.login(email, password);
      
      // Update state with result
      _loginState = result;
    } catch (e) {
      _loginState = ApiResponse.error(e.toString());
    }

    // Finished! Tell the UI to show the data or error
    notifyListeners();
  }
}

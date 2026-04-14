# ⚙️ App Configuration Layer

This folder contains the high-level configuration of the Flutter application. Because we are not using a separate routing file, `app.dart` serves as the central hub for the app's settings and dependency injection.

## 📄 File: `app.dart`

### What it does

1. **Global Provider Injection:** This is where we wrap the app in a `MultiProvider`. This ensures that data (like User Auth, Settings, or Themes) is accessible from any screen in the app.
2. **Theme Configuration:** It links our custom design tokens (from `lib/theme/`) to the actual Flutter framework.
3. **Root UI Setup:** It defines the `MaterialApp` and sets the `home` property (the first screen a user sees).

---

### 🚀 Injection Example (Code)

Here is how you should structure `app.dart`. This example shows how to inject your `AuthProvider` and `ThemeData` so your friend knows exactly where to add new providers.

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../theme/app_theme.dart';
import '../screens/auth/login_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. INJECTION: Wrap the entire app in MultiProvider
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        // Add more providers here as the app grows:
        // ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: const _MaterialAppSetup(),
    );
  }
}

class _MaterialAppSetup extends StatelessWidget {
  const _MaterialAppSetup();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter Project',
      debugShowCheckedModeBanner: false,
      
      // 2. THEME INJECTION: Pulling from lib/theme/
      theme: AppTheme.lightTheme, 
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // Switches based on phone settings

      // 3. HOME SCREEN: Since we aren't using a routes file, 
      // define the starting screen here.
      home: const LoginScreen(),
    );
  }
}

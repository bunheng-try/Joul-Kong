# 🎨 Theme & Styling

This folder is the "Style Guide" for the entire application. It contains the colors, typography, and component styles that ensure the app looks consistent on every screen.

## 📄 What is the goal of this folder?

Instead of hard-coding colors like `Colors.blue` or font sizes like `24.0` inside your widgets, you should reference the **Theme**. This makes it easy to:

1. **Change the Brand**: Change one color here, and it updates the whole app.
2. **Dark Mode**: Easily swap between Light and Dark themes.
3. **Consistency**: Ensure all buttons and text look identical across different features.

---

## 🚀 Structure of the Theme

### 1. `app_colors.dart`

Define your brand colors here as static constants.

```dart
class AppColors {
  static const primary = Color(0xFF6200EE);
  static const secondary = Color(0xFF03DAC6);
  static const error = Color(0xFFB00020);
  static const background = Color(0xFFF5F5F5);
}

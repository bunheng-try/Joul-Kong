# 🛠 Utils (Utilities)

The `utils/` folder contains small, reusable helper functions and static constants. Unlike **Services**, utility classes are "Pure"—they usually don't have a state and don't rely on external SDKs like Firebase or Stripe.

## 📄 What belongs in Utils?

If a piece of logic is purely mathematical, involves string formatting, or is a global constant that doesn't change, it belongs here.

### 1. Formatting

Converting data into a human-readable format.

* **Example**: `date_formatter.dart` (turns a DateTime into "5 mins ago"), `currency_formatter.dart`.

### 2. Validation

Simple logic to check if a string matches a pattern.

* **Example**: `validators.dart` (Regex for email, password strength, or phone numbers).

### 3. Helpers

Small logic shortcuts used in multiple places.

* **Example**: `device_utils.dart` (to hide the keyboard), `color_utils.dart` (to get a contrast color).

---

## 🚀 Code Examples

### `validators.dart` (Logic Helpers)

```dart
class AppValidators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
    return null;
  }
}

# 🧩 Shared Widgets (Global)

This folder contains **Reusable UI Components** that are used across multiple features in the app. These are the building blocks of our design system.

## 📄 What belongs here?

If a widget is used in **more than one feature** (e.g., used in both `Home` and `Profile`), it belongs here.

### 📂 Common Sub-folders

* **`buttons/`**: Custom buttons (Primary, Secondary, Outline).
* **`inputs/`**: Styled TextFields, Checkboxes, and Dropdowns.
* **`dialogs/`**: Standardized Pop-ups and Loading indicators.
* **`cards/`**: Consistent container styles for displaying data.
* **`layout/`**: Custom AppBars, BottomNavigationBars, or Spacing helpers.

---

## 🚀 The Difference: Global vs. Feature Widgets

| Type | Location | When to use? |
| :--- | :--- | :--- |
| **Global Widget** | `lib/widgets/` | When the widget is shared across the whole app. |
| **Feature Widget** | `lib/screens/{feature}/widgets/` | When the widget is unique to ONE screen/feature only. |

**Rule of Thumb:** Start widgets in the feature folder. If you find yourself copy-pasting that widget into a second feature, move it here to the global folder instead.

---

## 💻 Code Example: `primary_button.dart`

Global widgets should be flexible using parameters so they can be reused in different contexts.

```dart
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading 
        ? const CircularProgressIndicator() 
        : Text(text),
    );
  }
}

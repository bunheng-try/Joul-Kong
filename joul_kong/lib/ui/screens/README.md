# 📱 Screens & Feature UI

This folder contains the actual pages (Screens) of the application. We organize this folder by **Feature**, not by widget type.

## 📂 Structure of a Feature

Every feature (e.g., `auth`, `home`, `profile`) should have its own sub-folder.

### 1. The Screen File (`feature_screen.dart`)

This is the main Scaffold. It connects to the **Provider** and displays the layout.

### 2. The `widgets/` Sub-folder (Feature-Specific)

This is for components that are **only** used within this specific feature.

* **Rule:** If a widget is only used on the Login screen, put it in `screens/auth/widgets/`.
* **Rule:** If you find yourself needing that widget in the Profile screen later, move it to the global `lib/widgets/` folder.

---

## 🚀 Directory Example

```text
lib/screens/
└── auth/
    ├── login_screen.dart       // The main UI page
    ├── register_screen.dart    // Another page in the same feature
    └── widgets/                // Components ONLY for Auth
        ├── login_form.dart
        ├── social_auth_button.dart
        └── auth_header.dart

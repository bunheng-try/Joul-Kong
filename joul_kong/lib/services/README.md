# 🛠 Services Layer (The Platform Bridge)

The `services/` folder is for **System-Level Utilities** and **Third-Party SDKs**.

In this architecture, a Service is a "Specialist." It doesn't care about your app's specific business rules; it only cares about making a specific piece of technology work (like the Camera, GPS, or a Payment Gateway).

---

## 🎯 The Primary Role of a Service

The Service folder acts as the **Hardware & External API Wrapper**.

### 1. Hardware Interaction

If you need to talk to the physical device, it happens here.

* **Examples**: `location_service.dart`, `camera_service.dart`, `bluetooth_service.dart`.

### 2. Third-Party SDKs

If you are using a library from `pub.dev` that connects to an external company, wrap it in a service.

* **Examples**: `stripe_service.dart` (Payments), `firebase_messaging_service.dart` (Push Notifications).

### 3. App-Wide Utilities

Logic that needs to be available everywhere but isn't "Data."

* **Examples**: `connectivity_service.dart` (Check Wifi), `local_storage_service.dart` (Shared Preferences wrapper).

---

## ⚖️ Service vs. Repository vs. Provider

It is very easy to confuse these. Use this table as a guide:

| Feature | Where does it go? | Example |
| :--- | :--- | :--- |
| **App Data** | Repository | Fetching your user's "Order History" from your database. |
| **Business Logic** | Model / Repo | Calculating the 10% tax on a shopping cart. |
| **Hardware/SDK** | **Service** | Asking the phone for its current GPS Latitude/Longitude. |
| **UI State** | Provider | Showing a "Loading Spinner" while the GPS is searching. |

---

## 🚀 Code Example: `notification_service.dart`

Services are usually **Singletons** so that the entire app shares the same "Connection" to that hardware feature.

```dart
class NotificationService {
  // Singleton Setup
  NotificationService._internal();
  static final NotificationService instance = NotificationService._internal();

  // The service handles the "Technical" task
  Future<void> showLocalBanner(String title, String body) async {
    // Logic to talk to iOS/Android notification system
    print("Notification Sent: $title - $body");
  }
}

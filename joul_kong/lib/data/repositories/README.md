# 🏛 Repositories Layer

The Repository layer is the **Single Source of Truth** for your data. It sits between the raw Data Sources (Firebase/API) and the UI Logic (Providers).

---

## 🏗 The "What" vs. The "How"

We separate the **Interface** from the **Implementation**. This allows us to change our database or API in the future without breaking the UI.

### 1. The Interface (The "What")

This is an `abstract` class. It defines which methods are available. It acts as a **Contract**.

* **Where:** Created inside the repository file (e.g., `auth_repository.dart`).
* **Purpose:** To tell the app *what* data actions are possible.

```dart
// lib/data/repositories/auth_repository.dart
abstract class AuthRepository {
  Future<ApiResponse<UserModel>> login(String email, String password);
}

## Where is the "Business Logic"?

In this architecture, the **Repository** is the "Brain" of your data flow. It handles **Process Logic**.

###  Logic that BELONGS in the Repository:
* **Data Orchestration**: Deciding to merge data from two different APIs before sending it to the UI.
* **Caching Strategy**: Logic that says: *"If the data in the local database is older than 24 hours, fetch new data from the Remote Data Source."*
* **Error Transformation**: Catching a raw `401 SocketException` and turning it into a human-readable `ApiResponse.error("No Internet Connection")`.
* **Filtering/Sorting**: Taking a raw list from the API and sorting it alphabetically before the Provider sees it.

### Logic that does NOT belong here:
* **UI State**: Don't put `isLoading = true` here. That belongs in the **Provider**.
* **Calculations on a single object**: Logic like `user.getFullName()` or `product.isOutOfStock` belongs in the **Model**.
* **Device Hardware**: Talking to the Camera or GPS belongs in a **Service**.

---

### Code Example: Repository Logic
```dart
@override
Future<ApiResponse<List<Product>>> getProducts() async {
  try {
    // 1. Business Logic: Try local cache first
    final localData = await localDS.getProducts();
    
    if (localData.isNotEmpty) {
      return ApiResponse.completed(localData);
    }

    // 2. Business Logic: If cache empty, fetch from Remote
    final remoteData = await remoteDS.fetchProducts();
    
    // 3. Business Logic: Save new data to cache for next time
    await localDS.saveProducts(remoteData);
    
    return ApiResponse.completed(remoteData);
  } catch (e) {
    return ApiResponse.error("Could not load products.");
  }
}

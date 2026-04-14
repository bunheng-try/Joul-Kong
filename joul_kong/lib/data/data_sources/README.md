# 🔌 Data Sources Layer

This directory is the **lowest level** of the data layer.

### 💡 The Golden Rule

**Data Sources do not make decisions.** They only fetch or save data.

* They don't care about "App State."
* They don't care about "UI."
* They only return raw data (Maps) or simple Models.

### Which one to use?

* **Firebase:** For any official Google Firebase service.
* **Local:** For `SharedPreferences`, `SQLflite`, or `Hive` (Caching/Storage).
* **Remote:** For standard External APIs (HTTP/REST).

**Note:** The **Repository** (in `lib/data/repositories/`) will call these data sources to coordinate the data flow.

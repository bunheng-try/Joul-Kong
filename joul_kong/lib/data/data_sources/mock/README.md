# 🧪 Mock Data Sources

This folder is dedicated to mock / fake data implementations used during development and testing.

Instead of calling real APIs or databases, these classes return hardcoded or simulated data, allowing you to build and test features without depending on a backend.

### 📄 Usage

Use this folder when:

🚧 Backend API is not ready yet
🧪 You want to test UI or logic quickly
⚡ You need predictable/static data
🔌 You want to work offline

These classes should implement your repository contracts and return mocked models.

### 🚀 Example: mock_station_repository.dart
import '/models/station.dart';
import '/repositories/station_repository.dart';

```dart
class MockStationRepository implements StationRepository {
  @override
  Future<List<Station>> getStations() async {
    await Future.delayed(Duration(milliseconds: 500)); // simulate delay

    return [
      Station(id: '1', name: 'Station A', lat: 11.56, lng: 104.92),
      Station(id: '2', name: 'Station B', lat: 11.57, lng: 104.93),
    ];
  }

  @override
  Future<Station> getStationById(String stationId) async {
    final stations = await getStations();
    return ; 
  }

  @override
  Future<List<Station>> searchStations(String query) async {
    final stations = await getStations();
    return 
  }

  @override
  Future<List<Station>> getNearbyStations({
    required double latitude,
    required double longitude,
    double? radius,
  }) async {
    final stations = await getStations();

    // Simple mock: return all stations (no real distance calculation)
    return stations;
  }
}

import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../models/car.dart';
import '../models/maintenance_summary.dart';
import '../models/maintenance_record.dart';
import '../models/reminder.dart';
import '../services/api_service.dart';

class CarProvider with ChangeNotifier {
  final ApiService _api = ApiService();

  List<Car> _cars = [];
  final Map<String, MaintenanceSummary> _summaries = {};
  final Map<String, List<MaintenanceRecord>> _records = {};
  final Map<String, List<Reminder>> _reminders = {};
  
  bool _isLoading = false;
  String? _errorMessage;

  List<Car> get cars => _cars;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Car? getCar(String carId) => _cars.where((c) => c.id == carId).firstOrNull;
  MaintenanceSummary? getSummary(String carId) => _summaries[carId];
  List<MaintenanceRecord> getRecords(String carId) => _records[carId] ?? [];
  List<Reminder> getReminders(String carId) => _reminders[carId] ?? [];

  List<MaintenanceRecord> get allExpenses {
    final all = _records.values.expand((records) => records).toList();
    all.sort((a, b) => b.date.compareTo(a.date));
    return all;
  }

  Future<void> fetchCars() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _api.get('/cars');
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> carsJson = data['cars'] ?? [];
        _cars = carsJson.map((json) => Car.fromJson(json)).toList();
        
        // Fetch summaries for all cars
        for (var car in _cars) {
          await fetchCarSummary(car.id);
          // Optional: eagerly fetch records and reminders, or fetch them lazily in the details screen
        }
      } else {
        _errorMessage = 'Failed to load cars: ${response.statusCode}';
      }
    } catch (e) {
      _errorMessage = 'Error loading cars: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchAllRecords() async {
    for (var car in _cars) {
      await fetchRecords(car.id);
    }
  }

  Future<void> fetchCarSummary(String carId) async {
    try {
      final response = await _api.get('/cars/$carId/maintenance-summary');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _summaries[carId] = MaintenanceSummary.fromJson(data['summary']);
        notifyListeners();
      }
    } catch (e) {
      // Ignore error for now
    }
  }

  Future<void> fetchRecords(String carId) async {
    try {
      final response = await _api.get('/cars/$carId/maintenance-records');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> list = data['records'] ?? [];
        _records[carId] = list.map((j) => MaintenanceRecord.fromJson(j)).toList();
        notifyListeners();
      }
    } catch (e) {
      // Ignore
    }
  }

  Future<void> fetchReminders(String carId) async {
    try {
      final response = await _api.get('/cars/$carId/reminders');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> list = data['reminders'] ?? [];
        _reminders[carId] = list.map((j) => Reminder.fromJson(j)).toList();
        notifyListeners();
      }
    } catch (e) {
      // Ignore
    }
  }

  Future<bool> addCar(String make, String model, int year, int mileage) async {
    try {
      final response = await _api.post('/cars', body: {
        'make': make,
        'model': model,
        'year': year,
        'currentMileage': mileage,
      });

      if (response.statusCode == 201) {
        // Success! Re-fetch all cars so it shows up
        await fetchCars();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> logMileage(String carId, int mileage) async {
    try {
      final response = await _api.post('/cars/$carId/mileage-logs', body: {
        'mileage': mileage,
      });

      if (response.statusCode == 201) {
        // Success! Re-fetch cars (to get new currentMileage) and reminders
        await fetchCars();
        await fetchReminders(carId);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addMaintenanceRecord(String carId, Map<String, dynamic> data) async {
    try {
      final response = await _api.post('/cars/$carId/maintenance-records', body: data);

      if (response.statusCode == 201) {
        // Success! Re-fetch records, reminders, and cars (for the summary)
        await fetchRecords(carId);
        await fetchReminders(carId);
        await fetchCars();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateCar(String carId, String make, String model, int year, int mileage) async {
    try {
      final response = await _api.put('/cars/$carId', body: {
        'make': make,
        'model': model,
        'year': year,
        'currentMileage': mileage,
      });

      if (response.statusCode == 200) {
        await fetchCars();
        await fetchRecords(carId);
        await fetchReminders(carId);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteCar(String carId) async {
    try {
      final response = await _api.delete('/cars/$carId');
      if (response.statusCode == 200) {
        await fetchCars();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}

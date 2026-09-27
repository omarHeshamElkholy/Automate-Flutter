import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../models/service_center.dart';
import '../services/api_service.dart';

class SpecialistProvider with ChangeNotifier {
  final ApiService _api = ApiService();
  
  List<ServiceCenter> _serviceCenters = [];
  bool _isLoading = false;
  String? _error;

  List<ServiceCenter> get serviceCenters => _serviceCenters;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchServiceCenters({String? search, String? type}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Build query parameters
      final queryParams = <String, String>{};
      if (search != null && search.isNotEmpty) queryParams['search'] = search;
      if (type != null && type.isNotEmpty && type != 'All') queryParams['type'] = type;
      
      final queryString = Uri(queryParameters: queryParams).query;
      final url = '/service-centers${queryString.isNotEmpty ? '?$queryString' : ''}';

      final response = await _api.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> list = data['serviceCenters'] ?? [];
        _serviceCenters = list.map((j) => ServiceCenter.fromJson(j)).toList();
      } else {
        _error = ApiService.parseResponseError(response);
      }
    } catch (e) {
      _error = ApiService.parseError(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

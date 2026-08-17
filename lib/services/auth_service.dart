import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'api_service.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final ApiService _api = ApiService();

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'accessToken');
    return token != null;
  }

  Future<Map<String, dynamic>> requestOtp(String phone) async {
    try {
      final response = await _api.post('/auth/request-otp', body: {'phone': phone});
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return {'success': true, 'devOtp': data['devOtp'], 'isNewUser': data['isNewUser'] == true};
      }
      return {'success': false, 'error': 'Server error: ${response.statusCode}'};
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  Future<String?> verifyOtp(String phone, String code, {String? fullName}) async {
    try {
      final body = {'phone': phone, 'code': code};
      if (fullName != null && fullName.isNotEmpty) {
        body['fullName'] = fullName;
      }
      final response = await _api.post('/auth/verify-otp', body: body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['accessToken'] != null) {
          await _storage.write(key: 'accessToken', value: data['accessToken']);
        }
        if (data['refreshToken'] != null) {
          await _storage.write(key: 'refreshToken', value: data['refreshToken']);
        }
        return null; // success
      }
      return 'Verification failed: ${response.statusCode}';
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> logout() async {
    try {
      // Optional: notify backend of logout
      await _api.post('/auth/logout');
    } catch (e) {
      // Ignore network errors on logout
    } finally {
      // Always clear local tokens
      await _storage.delete(key: 'accessToken');
      await _storage.delete(key: 'refreshToken');
    }
  }

  Future<Map<String, dynamic>?> fetchProfile() async {
    try {
      final response = await _api.get('/auth/me');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['user'] as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}

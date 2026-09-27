import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  
  // Production backend URL
  String get baseUrl {
    return 'https://artsypuff.com/api/v1';
  }

  Future<Map<String, String>> _getHeaders() async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    
    final token = await _storage.read(key: 'accessToken');
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    
    return headers;
  }

  bool _isRefreshing = false;
  Future<http.Response>? _refreshFuture;

  Future<http.Response> _retryWithRefresh(
    Future<http.Response> Function() requestFunc,
    http.Response originalResponse,
  ) async {
    if (originalResponse.statusCode != 401) return originalResponse;

    final refreshToken = await _storage.read(key: 'refreshToken');
    if (refreshToken == null) return originalResponse;

    if (!_isRefreshing) {
      _isRefreshing = true;
      _refreshFuture = _performRefresh(refreshToken);
    }

    final refreshRes = await _refreshFuture!;
    
    if (refreshRes.statusCode == 200 || refreshRes.statusCode == 201) {
      return await requestFunc();
    } else {
      await _storage.delete(key: 'accessToken');
      await _storage.delete(key: 'refreshToken');
      return originalResponse;
    }
  }

  Future<http.Response> _performRefresh(String refreshToken) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/refresh'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'refreshToken': refreshToken}),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['accessToken'] != null) {
          await _storage.write(key: 'accessToken', value: data['accessToken']);
        }
        if (data['refreshToken'] != null) {
          await _storage.write(key: 'refreshToken', value: data['refreshToken']);
        }
      }
      return response;
    } finally {
      _isRefreshing = false;
      _refreshFuture = null;
    }
  }

  Future<http.Response> get(String endpoint) async {
    var headers = await _getHeaders();
    var response = await http.get(Uri.parse('$baseUrl$endpoint'), headers: headers);
    if (response.statusCode == 401 && !endpoint.contains('/auth/')) {
      response = await _retryWithRefresh(() async {
        headers = await _getHeaders();
        return await http.get(Uri.parse('$baseUrl$endpoint'), headers: headers);
      }, response);
    }
    return response;
  }

  Future<http.Response> post(String endpoint, {Map<String, dynamic>? body}) async {
    var headers = await _getHeaders();
    final uri = Uri.parse('$baseUrl$endpoint');
    final reqBody = body != null ? jsonEncode(body) : null;
    var response = await http.post(uri, headers: headers, body: reqBody);
    
    if (response.statusCode == 401 && !endpoint.contains('/auth/')) {
      response = await _retryWithRefresh(() async {
        headers = await _getHeaders();
        return await http.post(uri, headers: headers, body: reqBody);
      }, response);
    }
    return response;
  }

  Future<http.Response> put(String endpoint, {Map<String, dynamic>? body}) async {
    var headers = await _getHeaders();
    final uri = Uri.parse('$baseUrl$endpoint');
    final reqBody = body != null ? jsonEncode(body) : null;
    var response = await http.put(uri, headers: headers, body: reqBody);
    
    if (response.statusCode == 401 && !endpoint.contains('/auth/')) {
      response = await _retryWithRefresh(() async {
        headers = await _getHeaders();
        return await http.put(uri, headers: headers, body: reqBody);
      }, response);
    }
    return response;
  }

  Future<http.Response> delete(String endpoint) async {
    var headers = await _getHeaders();
    var response = await http.delete(Uri.parse('$baseUrl$endpoint'), headers: headers);
    
    if (response.statusCode == 401 && !endpoint.contains('/auth/')) {
      response = await _retryWithRefresh(() async {
        headers = await _getHeaders();
        return await http.delete(Uri.parse('$baseUrl$endpoint'), headers: headers);
      }, response);
    }
    return response;
  }

  static String parseError(dynamic e) {
    if (e is SocketException) {
      return 'No internet connection. Please check your network.';
    } else if (e is FormatException) {
      return 'Bad response format from server.';
    } else if (e.toString().contains('SocketException')) {
      return 'No internet connection. Please check your network.';
    } else {
      return 'An unexpected error occurred. Please try again.';
    }
  }

  static String parseResponseError(http.Response response) {
    try {
      final data = jsonDecode(response.body);
      return data['message'] ?? 'Server error: ${response.statusCode}';
    } catch (_) {
      return 'Server error: ${response.statusCode}';
    }
  }
}

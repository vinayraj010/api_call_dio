import 'package:dio/dio.dart';
import 'package:flutter_application_test/model/getApiData.dart';


class ApiService {
  static final Dio _dio = Dio();

  static void _setupDio() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Add any headers or configurations here
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // Handle the response
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        // Handle errors
        print('Error: ${e.message}');
        return handler.next(e);
      },
    ));
  }

  static Future<List<User>> fetchUsers() async {
    _setupDio();
    try {
      final response = await _dio.get('https://jsonplaceholder.typicode.com/users');
      final List<dynamic> data = response.data;
      return data.map((json) => User.fromJson(json)).toList();
    } catch (e) {
      print('Failed to load users: $e');
      throw e;
    }
  }
}

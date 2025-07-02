import 'package:dio/dio.dart';
import 'api_constants.dart';
import 'interceptors.dart';

class DioClient {
  final Dio _dio;

  DioClient._internal(this._dio);

  factory DioClient() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.fullBaseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        contentType: 'application/json',
      ),
    );

    dio.interceptors.addAll([
      LoggingInterceptor(),
      // Add AuthInterceptor(), RetryInterceptor() here if needed
    ]);

    return DioClient._internal(dio);
  }

  Dio get instance => _dio;
}

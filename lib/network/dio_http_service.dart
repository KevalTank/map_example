import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:map_example/constants/api_constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// Dio service that will call the network request
@injectable
class DioHttpService {
  late final Dio dio;

  String get baseUrl => ApiConstants.baseUrl;

  // Initializing the DIO object and interceptors
  DioHttpService() {
    dio = Dio(baseOptions);
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
  }

  // Creating base options
  BaseOptions get baseOptions => BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: ApiConstants.defaultConnectTimeout,
        receiveTimeout: ApiConstants.defaultReceiveTimeout,
      );

  // Get API method that will call the request
  Future<T?> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await dio.get<T>(
        endpoint,
        queryParameters: queryParameters,
        options: options,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}

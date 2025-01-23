import 'package:dio/dio.dart';
import 'package:sample_app/util/logger.dart';

/// [InterCeptor]
class CustomLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode != 200) {
      MyLog().e('Response [${response.statusCode}] => path: ${response.requestOptions.path}');
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    MyLog().e('Error [${err.response?.statusCode}] => path: ${err.requestOptions.path}');
    super.onError(err, handler);
  }
}

/* ---------------------------------- */
/* -------------서비스 본체------------- */
/* ---------------------------------- */

/// 싱글톤 패턴으로 만드는 데이터 통신 Service
class RestApiService {
  static final RestApiService _restApiService = RestApiService._internal();

  factory RestApiService() {
    return _restApiService;
  }

  Dio _dio = Dio();

  String apiBaseUrl = 'http://121';

  RestApiService._internal() {
    BaseOptions _options = BaseOptions(
      baseUrl: apiBaseUrl,
      connectTimeout: const Duration(milliseconds: 10000), // 서버에 연결을 시도하는데 부여되는 시간 제한
      receiveTimeout: const Duration(milliseconds: 10000), // 요청을 보낸 후, 서버로부터 데이터를 받는데 까지 부여되는 시간 제한
      sendTimeout: const Duration(milliseconds: 10000), // 연결이 된 후, 데이터를 보내는데 부우여되는 시간제한.
    );
    _dio = Dio(_options);
    _dio.interceptors.add(CustomLogInterceptor());  
  }
  Dio to() {
    return _dio;
  }
} // end class : RestApiService


// import 'package:cookie_jar/cookie_jar.dart';
// import 'package:dio/dio.dart';
// import 'package:dio_cookie_manager/dio_cookie_manager.dart';
// import 'package:flutter/foundation.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sample_app/access_service/rest_api_service/interceptor.dart';
// import 'package:sample_app/util/logger.dart';

// enum APIType { DEV, PROD }

// class ServerAService {
//   APIType apiType = APIType.DEV;
//   static final ServerAService _singleton = ServerAService._internal();
//   Dio dio = Dio();

//   late CookieJar cookieJar;

//   factory ServerAService() {
//     return _singleton;
//   }

//   String apiBaseUrl = 'http://121.254.254.170:3800';
//   String imgPath = '/img/';
//   bool isReleaseMode = false;

//   ServerAService._internal() {
//     isReleaseMode = kReleaseMode;
//   }

//   void setDev() {
//     apiBaseUrl = 'http://121.254.254.170:3800';
//     apiType = APIType.DEV;
//     MyLog().d('📌 API ${apiType.name}');
//   }

//   void setProd() {
//     apiBaseUrl = 'http://121.254.254.170:3800';
//     apiType = APIType.PROD;
//     MyLog().d('📌 API ${apiType.name}');
//   }

//   void setInternal() async {
//     setDev();
//     // if (appFlavor == 'prod') {
//     //   setProd();
//     // } else {
//     //   setDev();
//     // }

//     final dir = await getApplicationDocumentsDirectory();
//     final path = '${dir.path}/cookies.json';
//     cookieJar = PersistCookieJar(storage: FileStorage(path));

//     dio.options.baseUrl = apiBaseUrl;

//     dio.interceptors.clear();
//     dio.interceptors.add(CustomLogInterceptor(dio));
//     dio.interceptors.add(CookieManager(cookieJar));
//   }

//   Future<void> removeToken() async {
//     await cookieJar.delete(Uri.parse(apiBaseUrl));
//     final cookies = await cookieJar.loadForRequest(Uri.parse(apiBaseUrl));
//     MyLog().i('cookies : $cookies');
//   }
// }

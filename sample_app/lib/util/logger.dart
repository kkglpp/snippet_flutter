import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class MyLog {
  late Logger logger;

  static final MyLog _instance = MyLog._internal();

  factory MyLog() {
    return _instance;
  }

  d(String message) {
    if (kDebugMode) {
      logger.d(message);
    }
  }

  i(String message) {
    logger.i(message);
  }

  e(String message) {
    logger.e(message);
  }

  changeLoggingEnable() {
    logger = Logger(filter: LogEnableFilter());
  }

  MyLog._internal() {
    logger = Logger(printer: PrettyPrinter(methodCount: 0));
  }
}

class LogEnableFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return true;
  }
}

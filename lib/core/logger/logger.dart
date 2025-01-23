

import 'package:ansi_styles/ansi_styles.dart';

//*** Enums ***//
/// This enum is used to define the log level
/// It has four values: debug, error, warning, info
enum LogLevel {
  info,
  debug,
  warning,
  error,
  success,
}

//*** Extensions ***//
/// This extension is used to add a name property to the LogLevel enum
/// The name property returns the name of the log level
/// For example, LogLevel.debug.name returns 'DEBUG'
extension LogLevelExtension on LogLevel {
  String get name {
    return toString().toUpperCase();
  }
}

/// This extension is used to add a getColoredString method to the String class
/// The getColoredString method returns the string with the color based on the log level
extension StringColorExtension on String {
  String getColoredString(LogLevel logLevel) {
    var logText = '${logLevel.name}: $this';
    switch(logLevel) {
      case LogLevel.info:
        return logText;
      case LogLevel.debug:
        return AnsiStyles.blue(logText);
      case LogLevel.warning:
        return AnsiStyles.yellow(logText);
      case LogLevel.error:
        return AnsiStyles.red(logText);
      case LogLevel.success:
        return AnsiStyles.green(logText);
    }
  }
}

//*** Main Logger Class ***//
/// The BaseLogger class is used to log messages to the console
/// It has four methods: debug, error, warning, info
/// Each method logs the message with a different log level
/// The log method is used to log the message with the specified log level
/// The isActive property is used to enable or disable the logger
/// If the logger is disabled, the log method does nothing
/// @param isActive: A boolean value that specifies if the logger is active
/// @return: A BaseLogger object
class Logger {

  //*** Properties ***//
  bool isActive = true;

  //*** Constructor ***//
  Logger({this.isActive = true, LogLevel minimumLevel = LogLevel.debug}) {
    print('BaseLogger constructor');
  }

  //*** Public methods ***//
  void log(LogLevel level, String message) {
    if(!isActive) return;
    if(level.index < LogLevel.values.length) return;
    print(message.getColoredString(level));
  }

  void info(String message) {
    log(LogLevel.info, message);
  }

  void debug(String message) {
    log(LogLevel.debug, message);
  }

  void warning(String message) {
    log(LogLevel.warning, message);
  }

  void error(String message) {
    log(LogLevel.error, message);
  }

  void success(String message) {
    log(LogLevel.success, message);
  }
}
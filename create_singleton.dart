import 'dart:io';


/// Singleton Generator Script
///
/// This script generates a singleton class file based on the provided class name
/// from the command line. The generated class follows the singleton pattern and
/// includes basic usage examples in the comments above the generated code.
///
/// Usage:
///
/// To generate a singleton class:
/// ```sh
/// dart run create_singleton.dart <class_name>
/// ```
///
/// Example:
/// ```sh
/// dart run create_singleton.dart MyClass
/// ```
/// This will generate a Dart file named `my_class.dart` with a singleton class named `MyClass`.
///
/// The generated singleton class will have the following structure:
/// ```dart
/// /// Singleton class for MyClass
/// class MyClass {
///   // Private constructor
///   MyClass._internal();
///
///   // Singleton instance
///   static final MyClass _instance = MyClass._internal();
///
///   // Factory constructor
///   factory MyClass() => _instance;
/// }
/// ```
class SingletonGenerator {
  // Singleton pattern
  static final SingletonGenerator _instance = SingletonGenerator._internal();

  factory SingletonGenerator() {
    return _instance;
  }

  SingletonGenerator._internal();

  /// Converts a string to PascalCase (uppercase first letter)
  String toPascalCase(String input) {
    return input[0].toUpperCase() + input.substring(1);
  }

  /// Converts a string to snake_case (lowercase with underscores)
  String toSnakeCase(String input) {
    return input.replaceAllMapped(RegExp(r'([a-z])([A-Z])'), (match) {
      return '${match.group(1)}_${match.group(2)}';
    }).toLowerCase();
  }

  /// Generates a singleton class file with the given class name.
  void generateSingleton(String className) {
    if (className.isEmpty) {
      print('Class name cannot be empty.');
      return;
    }

    String pascalCaseName = toPascalCase(className);
    String snakeCaseName = toSnakeCase(className);
    String fileName = '$snakeCaseName.dart';
    String content = '''
/// Singleton class for $pascalCaseName
class $pascalCaseName {
  // Private constructor
  $pascalCaseName._internal();

  // Singleton instance
  static final $pascalCaseName _instance = $pascalCaseName._internal();

  // Factory constructor
  factory $pascalCaseName() => _instance;
}
''';

    File(fileName)
      ..createSync()
      ..writeAsStringSync(content);
    print('Singleton class for "$className" created successfully in $fileName!');
  }
}

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('Please provide a class name.');
    return;
  }

  final className = arguments[0];
  final singletonGenerator = SingletonGenerator();
  singletonGenerator.generateSingleton(className);
}
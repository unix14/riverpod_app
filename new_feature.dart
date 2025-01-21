/// Feature Generator Script
/// 
/// This script generates a feature folder structure for a Flutter project.
/// It creates the necessary folders and files based on the provided feature name
/// and optional components (screens and widgets). If no components are specified,
/// it generates the entire structure.
/// 
/// Usage:
/// 
/// To generate the entire feature structure:
/// dart run new_feature.dart <feature_name>
/// 
/// To generate only the widgets folder:
/// dart run new_feature.dart <feature_name> widget
/// 
/// To generate only the screens folder:
/// dart run new_feature.dart <feature_name> screen
/// 
/// To generate both screens and widgets folders:
/// dart run new_feature.dart <feature_name> screen widget
/// or
/// dart run new_feature.dart <feature_name> widget screen
/// or simply
/// dart run new_feature.dart <feature_name>

import 'dart:io';

class FeatureGenerator {
  // Singleton pattern
  static final FeatureGenerator _instance = FeatureGenerator._internal();

  factory FeatureGenerator() {
    return _instance;
  }

  FeatureGenerator._internal();

  /// Converts a string to snake_case (lowercase with underscores)
  String toSnakeCase(String input) {
    return input.replaceAllMapped(RegExp(r'([a-z])([A-Z])'), (match) {
      return '${match.group(1)}_${match.group(2)}';
    }).toLowerCase();
  }

  /// Converts a string to PascalCase (uppercase first letter)
  String toPascalCase(String input) {
    return input[0].toUpperCase() + input.substring(1);
  }

  /// Generates the folder and file structure for a given feature name.
  void generateFeature(String featureName, [List<String>? components]) {
    if (featureName.isEmpty) {
      print('Feature name cannot be empty.');
      return;
    }

    String basePath = 'lib/${toSnakeCase(featureName)}';

    // Define the folder and file structure
    Map<String, List<String>> structure = {
      'data/datasource': ['${toSnakeCase(featureName)}_data_source.dart'],
      'data/models': ['${toSnakeCase(featureName)}_model.dart'],
      'data/repositories': ['${toSnakeCase(featureName)}_repository_impl.dart'],
      'domain/entities': ['${toSnakeCase(featureName)}_entity.dart'],
      'domain/repositories': ['${toSnakeCase(featureName)}_repository.dart'],
      'domain/usecases': ['${toSnakeCase(featureName)}_usecase.dart'],
      'presentation/providers': ['${toSnakeCase(featureName)}_provider.dart'],
      'presentation/screens': ['${toSnakeCase(featureName)}_screen.dart'],
      'presentation/widgets': ['${toSnakeCase(featureName)}_widget.dart'],
    };

    // Define content templates for each file type
    Map<String, String> templates = {
      'data/datasource': '''
class ${toPascalCase(featureName)}DataSource {
  // Fetch data from remote or local source
  Future<void> fetchData() async {
    // TODO: Implement fetchData
  }
}
''',
      'data/models': '''
class ${toPascalCase(featureName)}Model {
  final int id;
  final String name;

  ${toPascalCase(featureName)}Model({required this.id, required this.name});

  factory ${toPascalCase(featureName)}Model.fromJson(Map<String, dynamic> json) {
    return ${toPascalCase(featureName)}Model(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
''',
      'data/repositories': '''
import '../models/${toSnakeCase(featureName)}_model.dart';
import '../../domain/entities/${toSnakeCase(featureName)}_entity.dart';
import '../../domain/repositories/${toSnakeCase(featureName)}_repository.dart';

class ${toPascalCase(featureName)}RepositoryImpl implements ${toPascalCase(featureName)}Repository {
  @override
  Future<${toPascalCase(featureName)}Entity> get${toPascalCase(featureName)}() async {
    // TODO: Fetch data from data source
    final model = ${toPascalCase(featureName)}Model(id: 1, name: 'Sample');
    return ${toPascalCase(featureName)}Entity(id: model.id, name: model.name);
  }
}
''',
      'domain/entities': '''
class ${toPascalCase(featureName)}Entity {
  final int id;
  final String name;

  ${toPascalCase(featureName)}Entity({required this.id, required this.name});
}
''',
      'domain/repositories': '''
import '../entities/${toSnakeCase(featureName)}_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/${toSnakeCase(featureName)}_repository_impl.dart';

abstract class ${toPascalCase(featureName)}Repository {
  Future<${toPascalCase(featureName)}Entity> get${toPascalCase(featureName)}();
}

final ${toSnakeCase(featureName)}RepositoryProvider = Provider<${toPascalCase(featureName)}Repository>((ref) {
  return ${toPascalCase(featureName)}RepositoryImpl();
});
''',
      'domain/usecases': '''
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/${toSnakeCase(featureName)}_repository.dart';
import '../entities/${toSnakeCase(featureName)}_entity.dart';

class ${toPascalCase(featureName)}UseCase {
  final ${toPascalCase(featureName)}Repository repository;

  ${toPascalCase(featureName)}UseCase(this.repository);

  Future<${toPascalCase(featureName)}Entity> execute() {
    return repository.get${toPascalCase(featureName)}();
  }
}

final ${toSnakeCase(featureName)}UseCaseProvider = Provider((ref) {
  final repository = ref.watch(${toSnakeCase(featureName)}RepositoryProvider);
  return ${toPascalCase(featureName)}UseCase(repository);
});
''',
      'presentation/providers': '''
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/${toSnakeCase(featureName)}_usecase.dart';
import '../../domain/entities/${toSnakeCase(featureName)}_entity.dart';

final ${toSnakeCase(featureName)}Provider = StateNotifierProvider<${toPascalCase(featureName)}Provider, ${toPascalCase(featureName)}Entity?>((ref) {
  final useCase = ref.watch(${toSnakeCase(featureName)}UseCaseProvider);
  return ${toPascalCase(featureName)}Provider(useCase);
});

class ${toPascalCase(featureName)}Provider extends StateNotifier<${toPascalCase(featureName)}Entity?> {
  final ${toPascalCase(featureName)}UseCase useCase;

  ${toPascalCase(featureName)}Provider(this.useCase) : super(null);

  Future<void> fetch${toPascalCase(featureName)}() async {
    state = await useCase.execute();
  }
}
''',
      'presentation/screens': '''
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/${toSnakeCase(featureName)}_provider.dart';

class ${toPascalCase(featureName)}Screen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entity = ref.watch(${toSnakeCase(featureName)}Provider);

    return Scaffold(
      appBar: AppBar(
        title: Text('${toPascalCase(featureName)} Screen'),
      ),
      body: Center(
        child: entity == null
            ? CircularProgressIndicator()
            : Text('Name: \${entity.name}'),
      ),
    );
  }
}
''',
      'presentation/widgets': '''
import 'package:flutter/material.dart';

class ${toPascalCase(featureName)}Widget extends StatelessWidget {
  final String name;

  ${toPascalCase(featureName)}Widget({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Text(name),
    );
  }
}
''',
    };

    // Create folders and files with content based on components
    bool createScreens = components == null || components.isEmpty || components.contains('screen');
    bool createWidgets = components == null || components.isEmpty || components.contains('widget');

    structure.forEach((folder, files) {
      if ((folder == 'presentation/screens' && !createScreens) ||
          (folder == 'presentation/widgets' && !createWidgets)) {
        return;
      }

      Directory('$basePath/$folder').createSync(recursive: true);
      print('Created folder: $basePath/$folder');

      for (String file in files) {
        String content = templates[folder] ?? '// TODO: Implement $file';
        File('$basePath/$folder/$file')
          ..createSync()
          ..writeAsStringSync(content);
        print('Created file: $basePath/$folder/$file');
      }
    });

    print('Feature structure for "$featureName" created successfully!');
  }
}

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('Please provide a feature name.');
    return;
  }

  final featureName = arguments[0];
  final components = arguments.length > 1 ? arguments.sublist(1) : null;

  final featureGenerator = FeatureGenerator();
  // Generate a feature programmatically
  featureGenerator.generateFeature(featureName, components);
}
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
  /// For example, 'MyFeatureName' becomes 'my_feature_name'
  String toSnakeCase(String input) {
    return input.replaceAllMapped(RegExp(r'([a-z])([A-Z])'), (match) {
      return '${match.group(1)}_${match.group(2)}';
    }).toLowerCase();
  }

  /// Converts a string to camelCase (lowercase first letter)
  /// For example, 'MyFeatureName' becomes 'myFeatureName'
  String toCamelCase(String input) {
    return input[0].toLowerCase() + input.substring(1);
  }

  /// Converts a string to PascalCase (uppercase first letter)
  /// For example, 'my_feature_name' becomes 'MyFeatureName'
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
import '../../domain/entities/${toSnakeCase(featureName)}_entity.dart';

class ${toPascalCase(featureName)}DataSource {
  // Fetch data from remote or local source
  Future<${toPascalCase(featureName)}Entity> fetchData() async {
    // TODO: Implement fetchData and return a ${toPascalCase(featureName)}Entity
    return ${toPascalCase(featureName)}Entity(id: 1, name: 'Sample Name');
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
import '../datasource/${toSnakeCase(featureName)}_data_source.dart';
import '../../domain/entities/${toSnakeCase(featureName)}_entity.dart';
import '../../domain/repositories/${toSnakeCase(featureName)}_repository.dart';

class ${toPascalCase(featureName)}RepositoryImpl implements ${toPascalCase(featureName)}Repository {
  final ${toPascalCase(featureName)}DataSource dataSource;

  ${toPascalCase(featureName)}RepositoryImpl(this.dataSource);

  @override
  Future<${toPascalCase(featureName)}Entity> get${toPascalCase(featureName)}() async {
    // Fetch data from data source
    return await dataSource.fetchData();
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
import '../../data/datasource/${toSnakeCase(featureName)}_data_source.dart';

abstract class ${toPascalCase(featureName)}Repository {
  Future<${toPascalCase(featureName)}Entity> get${toPascalCase(featureName)}();
}

final ${toCamelCase(featureName)}RepositoryProvider = Provider<${toPascalCase(featureName)}Repository>((ref) {
  final dataSource = ${toPascalCase(featureName)}DataSource();
  return ${toPascalCase(featureName)}RepositoryImpl(dataSource);
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

final ${toCamelCase(featureName)}UseCaseProvider = Provider((ref) {
  final repository = ref.watch(${toCamelCase(featureName)}RepositoryProvider);
  return ${toPascalCase(featureName)}UseCase(repository);
});
''',
      'presentation/providers': '''
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/${toSnakeCase(featureName)}_usecase.dart';
import '../../domain/entities/${toSnakeCase(featureName)}_entity.dart';

final ${toCamelCase(featureName)}ControllerProvider = AutoDisposeAsyncNotifierProvider<${toPascalCase(featureName)}Controller, ${toPascalCase(featureName)}Entity>(
  () => ${toPascalCase(featureName)}Controller(),
);

class ${toPascalCase(featureName)}Controller extends AutoDisposeAsyncNotifier<${toPascalCase(featureName)}Entity> {
  @override
  FutureOr<${toPascalCase(featureName)}Entity> build() async {
    state = AsyncValue.loading();
    try {
      final useCase = ref.read(${toCamelCase(featureName)}UseCaseProvider);
      final entity = await useCase.execute();
      state = AsyncValue.data(entity);
      return entity;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      rethrow;
    }
  }
}
''',
      'presentation/screens': '''
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/${toSnakeCase(featureName)}_provider.dart';
${(components == null || components != null && components.contains('widget')) ? "import '../widgets/${toSnakeCase(featureName)}_widget.dart';" : ''}

class ${toPascalCase(featureName)}Screen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(${toCamelCase(featureName)}ControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('${toPascalCase(featureName)} Screen'),
      ),
      body: Center(
        child: state.when(
          data: (data) => ${(components == null || components != null && components.contains('widget')) ? "${toPascalCase(featureName)}Widget(entity: data)" : "Text('Name: \${data.name}')"},
          error: (error, _) => Text('Error: \${error.toString()}'),
          loading: () => CircularProgressIndicator(),
        ),
      ),
    );
  }
}
''',
      'presentation/widgets': '''
import 'package:flutter/material.dart';
import '../../domain/entities/${toSnakeCase(featureName)}_entity.dart';

class ${toPascalCase(featureName)}Widget extends StatelessWidget {
  final ${toPascalCase(featureName)}Entity entity;

  ${toPascalCase(featureName)}Widget({required this.entity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Text('Name: \${entity.name}'),
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
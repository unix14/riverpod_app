import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class StorageManager{

  static const _defaultBoxKey = "cbc_storage_manager_default_box_key";
  late Box _defaultBox;


  Future<StorageManager> init() async {
    /// init Hive
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    _defaultBox = await Hive.openBox(_defaultBoxKey);

    debugPrint('Hive initialized');
    return this;
  }


  put(String key, dynamic value) async {
    await _defaultBox.put(key, value);
    return this;
  }

  get(String key, {dynamic defaultValue}) async {
    return await _defaultBox.get(key, defaultValue: defaultValue);
  }
}
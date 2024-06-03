import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

const _kPreferenceStorageBox = 'energy_games_preference';

class PreferenceStorageService {
  /// Initialize [Hive] database and register needed hive type adapters
  Future<void> init() async {
    await Hive.openBox(_kPreferenceStorageBox);
  }

  /// To clear the box
  Future<void> clear() async {
    await Hive.box(_kPreferenceStorageBox).clear();
  }

  /// To delete a saved item
  Future<void> delete(String key) async {
    await Hive.box(_kPreferenceStorageBox).delete(key);
  }

  /// To read a value
  dynamic read(String key) {
    return Hive.box(_kPreferenceStorageBox).get(key);
  }

  /// To listen to changes to an item
  ValueListenable<Box<dynamic>> listenable(List<String> keys) {
    return Hive.box(_kPreferenceStorageBox).listenable(keys: keys);
  }

  /// To update an item
  Future<void> write(String key, value) async {
    await Hive.box(_kPreferenceStorageBox).put(key, value);
  }
}

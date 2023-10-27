import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'secure_storage.dart';

class SecureStorageImpl implements SecureStorage {
  final storage = const FlutterSecureStorage();

  @override
  getFromStorage(key) async {
    return await storage.read(key: key);
  }

  @override
  Future<bool> checkFromStorage(String key) async {
    try {
      return await storage.containsKey(key: key);
    } catch (e) {
      return false;
    }
  }

  @override
  void saveToStorage(String key, String value) async {
    try {
      return await storage.write(key: key, value: value);
    } catch (e) {
      rethrow;
    }
  }

  @override
  void deleteAllValueFromStorage() async {
    try {
      return await storage.deleteAll();
    } catch (e) {
      rethrow;
    }
  }

  @override
  void deleteFromStorage(String key) async {
    try {
      return await storage.delete(key: key);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Map<String, dynamic> getAllValuesFromStorage() {
    // TODO: implement getAllValuesFromStorage
    throw UnimplementedError();
  }
}

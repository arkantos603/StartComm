import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';

class SecureStorage {
  const SecureStorage();

  final _secureStorage = const FlutterSecureStorage();

  Future<void> write({required String key, String? value}) async {
    debugPrint('SecureStorage: Writing to secure storage: $key = $value');
    await _secureStorage.write(
      key: key,
      value: value,
    );
  }

  Future<String?> readOne({required String key}) async {
    debugPrint('SecureStorage: Reading from secure storage: $key');
    return await _secureStorage.read(key: key);
  }

  Future<Map<String, String>> readAll() async {
    debugPrint('SecureStorage: Reading all from secure storage');
    return await _secureStorage.readAll();
  }

  Future<void> deleteOne({required String key}) async {
    debugPrint('SecureStorage: Deleting from secure storage: $key');
    await _secureStorage.delete(key: key);
  }

  Future<void> deleteAll() async {
    debugPrint('SecureStorage: Deleting all from secure storage');
    await _secureStorage.deleteAll();
  }
}
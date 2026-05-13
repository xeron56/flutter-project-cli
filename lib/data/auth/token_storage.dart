import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Secure persistence for auth tokens.
///
/// Lives in the data layer so blocs and interceptors can both depend on the
/// same abstraction. Backed by the OS keystore via `flutter_secure_storage`.
abstract class TokenStorage {
  Future<String?> readToken();

  Future<void> writeToken(String token);

  Future<void> clear();
}

class SecureTokenStorage implements TokenStorage {
  SecureTokenStorage([FlutterSecureStorage? storage])
      : _storage = storage ?? const FlutterSecureStorage();

  static const _tokenKey = 'auth.token';

  final FlutterSecureStorage _storage;

  @override
  Future<String?> readToken() => _storage.read(key: _tokenKey);

  @override
  Future<void> writeToken(String token) =>
      _storage.write(key: _tokenKey, value: token);

  @override
  Future<void> clear() => _storage.delete(key: _tokenKey);
}

abstract class ISharedPreferencesException implements Exception {
  final String? message;

  const ISharedPreferencesException([this.message]);

  @override
  String toString() {
    String result = 'ISharedPreferencesException';
    if (message is String) return '$result: $message';
    return result;
  }
}

class SharedPreferencesException extends ISharedPreferencesException {
  const SharedPreferencesException([String? message]) : super(message);
}
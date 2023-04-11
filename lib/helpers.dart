import 'dart:math';

class Helpers {
  static String generateNonce([int length = 16]) {
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
  }
}

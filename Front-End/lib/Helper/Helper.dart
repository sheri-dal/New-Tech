import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Helper {
  static String PasswordHash(String password) {
    // var password = "password";
    // var salt = 'UVocjgjgXg8P7zIsC93kKlRU8sPbTBhsAMFLnLUPDRYFIWAk';
    // var saltedPassword = salt + password;
    // var bytes = utf8.encode(saltedPassword);
    // var hash = sha256.convert(bytes);
    var key = utf8.encode('p@ssw0rd');
    var bytes = utf8.encode(password);

    var hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
    var digest = hmacSha256.convert(bytes);
    return digest.toString();
  }

  static bool isEmailValid(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }

  static Future<void> deleteDatabase() async {
    var documentsDirectory = await getDatabasesPath();
    String path = join(documentsDirectory, 'CancerApp.db');
    databaseFactory.deleteDatabase(path);
  }
}

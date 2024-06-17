import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:supervisor_smile/feautre/feaure.dart';

class AuthService {
  static Future<UserModel> signInWithEmailAndPassword(
      String email, String password) async {
    const url = '$BASE_URL/auth/login';
    final body = jsonEncode({'email': email, 'password': password});
    final headers = {'Content-Type': 'application/json'};
    final response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      return UserModel.fromJson(responseData);
    } else {
      throw Exception('Faild Login');
    }
  }
}

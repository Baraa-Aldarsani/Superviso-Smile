import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supervisor_smile/feautre/feaure.dart';

class StudentService {
  static Future<List<StudentModel>> getStudentInfo(int id) async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    final response = await http.get(
        Uri.parse('$BASE_URL/profile/getStudentsRelatedPatient?patient_id=$id'),
        headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data
          .map<StudentModel>((jsonData) => StudentModel.fromJson(jsonData))
          .toList();
    } else {
      throw Exception('Failed to fetch student');
    }
  }
}

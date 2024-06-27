import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:supervisor_smile/feautre/feaure.dart';
import 'package:http/http.dart' as http;

class HomeService {
  static Future<List<SectionModel>> getAllSection() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    final response = await http.get(
        Uri.parse('$BASE_URL/profile/getMySections'),
        headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data
          .map<SectionModel>((jsonData) => SectionModel.fromJson(jsonData))
          .toList();
    } else {
      throw Exception('Failed to fetch sections');
    }
  }

  static Future<List<ClinicModel>> getAllClinicBySectionID(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    final response = await http.get(
        Uri.parse('$BASE_URL/profile/getClinicsBySectionId?section_id=$id'),
        headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> data = json.decode(response.body)['data'];

      return data
          .map<ClinicModel>((jsonData) => ClinicModel.fromJson(jsonData))
          .toList();
    } else {
      throw Exception('Failed to fetch clinics');
    }
  }

  static Future<List<SessionModel>> getSessionToday(int id, String date) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    final response = await http.get(
        Uri.parse(
            '$BASE_URL/profile/getSessionToday?clinic_id=$id&&history=$date'),
        headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> data = json.decode(response.body)['data'];

      return data
          .map<SessionModel>((jsonData) => SessionModel.fromJson(jsonData))
          .toList();
    } else {
      throw Exception('Failed to fetch session today');
    }
  }

  static Future<List<PatientModel>> getPatientToday(int id, String date) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    final response = await http.get(
        Uri.parse(
            '$BASE_URL/profile/getPatientToday?clinic_id=$id&&history=$date'),
        headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data
          .map<PatientModel>((jsonData) => PatientModel.fromJson(jsonData))
          .toList();
    } else {
      throw Exception('Failed to fetch patient today');
    }
  }
}

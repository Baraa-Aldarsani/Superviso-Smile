import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supervisor_smile/feautre/feaure.dart';

class SessionService {
  static Future<List<SessionModel>> getSessionList(
      int patientID, int studenID) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    final response = await http.get(
        Uri.parse(
            '$BASE_URL/profile/getSessionsRelatedPatientStudent?patient_id=$patientID&&student_id=$studenID'),
        headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data
          .map<SessionModel>((jsonData) => SessionModel.fromJson(jsonData))
          .toList();
    } else {
      throw Exception('Failed to fetch session List.');
    }
  }

  static Future<void> addSessionNote(
      int sessionId, String note, double evaluation) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    final response = await http.put(
      Uri.parse('$BASE_URL/profile/addSessionNotes'),
      headers: {'Authorization': 'Bearer $token'},
      body: {
        "session_id": sessionId.toString(),
        "notes": note,
        "evaluation": evaluation.toString(),
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("success update session");
    } else {
      throw "Faild update session";
    }
  }
}

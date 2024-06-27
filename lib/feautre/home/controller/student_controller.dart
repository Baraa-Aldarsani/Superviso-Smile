import 'package:get/get.dart';
import 'package:supervisor_smile/apis/apis.dart';
import 'package:supervisor_smile/feautre/feaure.dart';

class StudentController extends GetxController {
  List<StudentModel> studentInfo = [];
  Future<void> getInfoStudent(int id) async {
    try {
      final List<StudentModel> fetchData =
          await StudentService.getStudentInfo(id);
      studentInfo.assignAll(fetchData);
    } catch (e) {
      print("Error : $e");
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:supervisor_smile/apis/apis.dart';
import 'package:supervisor_smile/core/core.dart';
import 'package:supervisor_smile/feautre/feaure.dart';

class HomeController extends GetxController {
  RxInt selectedIndexSection = 0.obs;
  RxInt selectedIndexClinic = 0.obs;
  RxInt selectedIndexbody = 0.obs;
  RxInt selectedSection = 0.obs;
  var currentDate = ''.obs;
  var title = <String>[
    "Daily sessions",
    "Current patients",
  ].obs;

  @override
  void onInit() async {
    updateDate();
    await getSections();
    sections.listen((_) {
      if (sections.isNotEmpty) selectedSection.value = sections[0].id;
    });
    await getClinics(selectedSection.value);

    if (clinics.isNotEmpty) getSessionToday(clinics[0].id, currentDate.value);
    super.onInit();
  }

  void updateDate() {
    DateTime now = DateTime.now();
    currentDate.value = DateFormat('yyyy/MM/dd').format(now);
  }

  void changeColorSection(int index) {
    selectedIndexSection.value = index;
    update();
  }

  Color getColorButtonsSection(int index) {
    return selectedIndexSection.value == index ? Palette.primary : Colors.white;
  }

  Color getColorTextSection(int index) {
    return selectedIndexSection.value == index ? Colors.white : Palette.primary;
  }

  void changeColorClinic(int index) {
    selectedIndexClinic.value = index;
    update();
  }

  Color getColorButtonsClinic(int index) {
    return selectedIndexClinic.value == index ? Palette.primary : Colors.white;
  }

  Color getColorTextClinic(int index) {
    return selectedIndexClinic.value == index ? Colors.white : Palette.primary;
  }

  void changeColorbody(int index) {
    selectedIndexbody.value = index;
    update();
  }

  Color getColorButtonsbody(int index) {
    return selectedIndexbody.value == index ? Palette.primary : Colors.white;
  }

  Color getColorTextbody(int index) {
    return selectedIndexbody.value == index ? Colors.white : Palette.primary;
  }

  var sections = <SectionModel>[].obs;
  RxBool isLoadingSec = false.obs;
  Future<void> getSections() async {
    isLoadingSec.value = true;
    try {
      final List<SectionModel> fetchData = await HomeService.getAllSection();
      sections.assignAll(fetchData);
      selectedSection.value = sections[0].id;
    } catch (e) {
      rethrow;
    } finally {
      isLoadingSec.value = false;
    }
  }

  var clinics = <ClinicModel>[].obs;
  RxBool isLoadingClinic = false.obs;
  Future<void> getClinics(int id) async {
    isLoadingClinic.value = true;
    try {
      final List<ClinicModel> fetchData =
          await HomeService.getAllClinicBySectionID(id);
      clinics.assignAll(fetchData);
    } catch (e) {
      rethrow;
    } finally {
      isLoadingClinic.value = false;
    }
  }

  var session = <SessionModel>[].obs;
  RxBool isLoadingSessionToday = false.obs;
  Future<void> getSessionToday(int id, String date) async {
    isLoadingSessionToday.value = true;
    try {
      final List<SessionModel> fetchData =
          await HomeService.getSessionToday(id, date);
      session.assignAll(fetchData);
    } catch (e) {
      rethrow;
    } finally {
      isLoadingSessionToday.value = false;
    }
  }

  var patient = <PatientModel>[].obs;
  RxBool isLoadingpatientToday = false.obs;
  Future<void> getPatientToday(int id, String date) async {
    isLoadingpatientToday.value = true;
    try {
      final List<PatientModel> fetchData =
          await HomeService.getPatientToday(id, date);
      patient.assignAll(fetchData);
    } catch (e) {
      rethrow;
    } finally {
      isLoadingpatientToday.value = false;
    }
  }
}

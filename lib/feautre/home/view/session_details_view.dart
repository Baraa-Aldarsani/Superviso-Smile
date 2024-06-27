// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supervisor_smile/core/core.dart';
import 'package:supervisor_smile/feautre/feaure.dart';

class SessionDetailsView extends StatelessWidget {
  SessionDetailsView({
    super.key,
    required this.sessionModel,
    required this.patientModel,
    required this.studentModel,
  });
  final SessionModel sessionModel;
  final PatientModel patientModel;
  final StudentModel studentModel;
  final SessionController _controller = Get.put(SessionController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Session Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Container(
              height: 490,
              decoration: const BoxDecoration(
                  color: Palette.primaryLight,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Patient Name',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("${patientModel.fName} ${patientModel.lName}"),
                    ],
                  ),
                  const Divider(
                    thickness: 0.2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Student Name',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("${studentModel.fName} ${studentModel.lName}"),
                    ],
                  ),
                  const Divider(
                    thickness: 0.2,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Student Notes',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(sessionModel.studentNote),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 0.2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Session Time',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(sessionModel.time),
                    ],
                  ),
                  const Divider(
                    thickness: 0.2,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Supervisor Notes',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(sessionModel.supervisorNote),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 0.2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Evaluation',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(sessionModel.evaluation != null
                          ? sessionModel.evaluation.toString()
                          : '0.0'),
                    ],
                  ),
                  const Divider(
                    thickness: 0.2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Status',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(sessionModel.status),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            ElevatedBtn(
                title: "Add Notes and Evaluation",
                onPressed: () {
                  _controller.bottomSheetUpdate(sessionModel);
                },
                width: 180,
                height: 50)
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:supervisor_smile/apis/session_service.dart';
import 'package:supervisor_smile/core/core.dart';
import 'package:supervisor_smile/feautre/feaure.dart';

class SessionController extends GetxController {
  var session = <SessionModel>[].obs;
  RxBool isLoading = false.obs;
  Future<void> getSession(int patientID, int studenID) async {
    isLoading.value = true;
    try {
      final List<SessionModel> fetchData =
          await SessionService.getSessionList(patientID, studenID);
      session.assignAll(fetchData);
    } catch (e) {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  void bottomSheetUpdate(SessionModel sessionModel) {
    Get.bottomSheet(
      UpdateSessionBottomSheet(
        sessionModel: sessionModel,
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  RxDouble rating = 0.0.obs;

  Future<void> addSessionNote(
      int sessionId, String note, double evaluation) async {
    ScaffoldMessenger.of(Get.context!)
        .showSnackBar(const SnackBar(content: Text('Processing Data ...')));
    try {
      print(evaluation);
      print(note);
      await SessionService.addSessionNote(sessionId, note, evaluation);
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
        content: Text('Success update session'),
        backgroundColor: Palette.primary,
      ));
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
        content: Text('Faild update session'),
        backgroundColor: Palette.red,
      ));
      rethrow;
    }
  }
}

class UpdateSessionBottomSheet extends StatelessWidget {
  final TextEditingController note = TextEditingController();

  final SessionController _controller = Get.put(SessionController());
  final SessionModel sessionModel;
  UpdateSessionBottomSheet({super.key, required this.sessionModel});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380,
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          const Text(
            'Add notes & evaluation',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Your rating',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                _controller.rating.value = rating;
              },
            ),
          ),
          const SizedBox(height: 20),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Do you have any feedback?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          TextFormField(
            controller: note,
            decoration: const InputDecoration(
              labelText: 'Notes',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 20),
          MaterialButton(
            color: Palette.primary,
            minWidth: 200,
            onPressed: () {
              if (_controller.rating != 0) {
                Get.back();
                _controller.addSessionNote(
                    sessionModel.id, note.text, _controller.rating.value);
              }
            },
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

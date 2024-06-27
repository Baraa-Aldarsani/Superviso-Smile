// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supervisor_smile/core/core.dart';
import 'package:supervisor_smile/feautre/feaure.dart';

class SessionView extends StatelessWidget {
  SessionView(
      {super.key, required this.patientModel, required this.studentModel});
  final SessionController _controller = Get.put(SessionController());
  final PatientModel patientModel;
  final StudentModel studentModel;
  List<Color> colors = [
    Colors.white,
    Palette.primary,
    Palette.grey,
    Colors.white,
    const Color.fromARGB(255, 159, 199, 208),
    Palette.grey,
    Colors.white,
    Palette.primary,
    Palette.grey,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.background,
        title: const Text("Patient Sessions"),
        titleTextStyle: Theme.of(context).textTheme.headlineSmall,
      ),
      body: FutureBuilder(
          future: _controller.getSession(patientModel.id, studentModel.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text("Error"));
            } else {
              return ListView.builder(
                itemCount: _controller.session.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Get.to(() => SessionDetailsView(
                          sessionModel: _controller.session[index],
                          patientModel: patientModel,
                          studentModel: studentModel,
                        ));
                  },
                  child: Container(
                    color: index + 1 < colors.length
                        ? colors[index + 1]
                        : Colors.transparent,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.elliptical(200, 300)),
                        color: colors[index],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, top: 10),
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                width: 42,
                                height: 42,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(100)),
                                  border: Border.all(
                                      width: 0.4, color: Palette.primary),
                                ),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(25)),
                                  child: Container(
                                    alignment: Alignment.center,
                                    color: Palette.primaryDark,
                                    child: Text(
                                      "${index + 1}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .extension<EXTColors>()!
                                                .background,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "${patientModel.fName} ${patientModel.lName}"),
                                  Text(
                                      "${studentModel.fName} ${studentModel.lName}"),
                                  Text(_controller.session[index].date),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const ColorDot(
                                            fillcolor:
                                                Color.fromRGBO(176, 185, 67, 1),
                                            isSelected: true,
                                          ),
                                          Text(
                                            _controller.session[index].status,
                                          ),
                                        ],
                                      ),
                                      Text(
                                          "Evaluation : ${_controller.session[index].evaluation.toString()}"),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }
}

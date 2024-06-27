import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:supervisor_smile/core/core.dart';
import 'package:supervisor_smile/feautre/feaure.dart';

class StudentView extends StatelessWidget {
  StudentView({super.key, required this.patientModel});
  final StudentController _controller = Get.put(StudentController());
  final PatientModel patientModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.background,
        title: const Text("Student Sessions"),
        titleTextStyle: Theme.of(context).textTheme.headlineSmall,
      ),
      body: FutureBuilder(
          future: _controller.getInfoStudent(patientModel.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: ListView.builder(
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Palette.primaryLight,
                      margin: const EdgeInsets.all(10),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Palette.primaryLight,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        height: 60,
                      ),
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text("Error"));
            } else {
              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ListView.separated(
                  itemCount: _controller.studentInfo.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 55,
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: index % 2 == 0 ? Palette.grey : Palette.primary,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade500,
                            offset: const Offset(1.5, 1.5),
                            blurRadius: 2,
                          )
                        ],
                      ),
                      child: InkWell(
                        onTap: () {
                          Get.to(
                            () => SessionView(
                                patientModel: patientModel,
                                studentModel: _controller.studentInfo[index]),
                          );
                        },
                        child: _bodyWidget(context, index),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 15),
                ),
              );
            }
          }),
    );
  }

  Widget _bodyWidget(BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Palette.primaryDark,
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          height: 40,
          width: 40,
          alignment: Alignment.center,
          child: Text(
            _controller.studentInfo[index].year,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              '${_controller.studentInfo[index].fName} ${_controller.studentInfo[index].lName}',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).extension<EXTColors>()!.black),
            ),
            Row(
              children: [
                Text(
                  _controller.studentInfo[index].specialization,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(width: 165),
                Text(
                  _controller.studentInfo[index].gender,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(width: 10),
        const Icon(Icons.arrow_forward_ios, color: Palette.primaryDark)
      ],
    );
  }
}

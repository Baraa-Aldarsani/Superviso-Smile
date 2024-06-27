// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:supervisor_smile/core/core.dart';
import 'package:supervisor_smile/feautre/feaure.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final HomeController _controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.primary,
        title: const Text('Home Screen'),
        titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).extension<EXTColors>()!.background,
            ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              iconSize: 30,
            ),
          )
        ],
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset("assets/images/Capture.png"),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle(context, "Orthodontic Department"),
              _headerWidget(),
              const SizedBox(height: 15),
              _buildSectionTitle(context, "Clinic number"),
              _clinicWidget(),
              const SizedBox(height: 15),
              _buildSectionTitle(context, "Sessions and patients"),
              _bodyWidget(),
              const SizedBox(height: 15),
              Obx(
                () => _controller.selectedIndexbody == 0
                    ? _dailySession()
                    : _currentPatient(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _dailySession() {
    return Obx(() {
      if (_controller.isLoadingSessionToday.value) {
        return Expanded(
          child: Shimmer.fromColors(
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
          ),
        );
      }
      return Expanded(
        child: ListView.builder(
          itemBuilder: (contex, index) {
            final session = _controller.session[index];
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
                child: ListTile(
                  title: Text(session.time),
                  subtitle: Text(session.status),
                ),
              ),
            );
          },
          itemCount: _controller.session.length,
        ),
      );
    });
  }

  Widget _currentPatient() {
    return Obx(() {
      if (_controller.isLoadingpatientToday.value) {
        return Expanded(
          child: Shimmer.fromColors(
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
                    height: 100,
                  ),
                );
              },
            ),
          ),
        );
      }
      return Expanded(
        child: ListView.builder(
          itemBuilder: (contex, index) {
            final patient = _controller.patient[index];
            return Card(
              color: Palette.primaryLight,
              margin: const EdgeInsets.all(10),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(patient.image),
                  radius: 30,
                ),
                title: Text(
                  '${patient.fName} ${patient.lName}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Text('Gender: ${patient.gender}'),
                    Text('Birthday: ${patient.birthday}'),
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Get.to(() => StudentView(patientModel: patient));
                },
              ),
            );
          },
          itemCount: _controller.patient.length,
        ),
      );
    });
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(title, style: Theme.of(context).textTheme.bodyLarge),
    );
  }

  SizedBox _bodyWidget() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 2,
        itemBuilder: (context, index) {
          return GetBuilder(
            init: HomeController(),
            builder: (controller) => InkWell(
              onTap: () {
                _controller.changeColorbody(index);
              },
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              splashColor: Palette.primaryLight,
              child: Container(
                width: MediaQuery.of(context).size.width / 2.18,
                decoration: BoxDecoration(
                    color: _controller.getColorButtonsbody(index),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(width: 1, color: Palette.primary)),
                alignment: Alignment.center,
                child: Text(
                  _controller.title[index],
                  style: TextStyle(
                    color: _controller.getColorTextbody(index),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(width: 10),
      ),
    );
  }

  SizedBox _clinicWidget() {
    return SizedBox(
      height: 40,
      child: Obx(() {
        if (_controller.isLoadingClinic.value) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              itemBuilder: (context, index) {
                return Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                    color: Palette.primaryLight,
                  ),
                  child: Container(
                    width: 50,
                    decoration: BoxDecoration(
                        color: _controller.getColorButtonsClinic(index),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(2)),
                        border: Border.all(width: 1, color: Palette.primary)),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(width: 10),
            ),
          );
        }
        return ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: _controller.clinics.length,
          itemBuilder: (context, index) {
            final clinic = _controller.clinics[index];
            return GetBuilder(
              init: HomeController(),
              builder: (controller) => InkWell(
                onTap: () {
                  controller.changeColorClinic(index);
                  _controller.getSessionToday(
                      clinic.id, _controller.currentDate.value);
                  _controller.getPatientToday(
                      clinic.id, _controller.currentDate.value);
                },
                borderRadius: const BorderRadius.all(Radius.circular(2)),
                splashColor: Palette.primaryLight,
                child: Container(
                  width: 50,
                  decoration: BoxDecoration(
                      color: controller.getColorButtonsClinic(index),
                      borderRadius: const BorderRadius.all(Radius.circular(2)),
                      border: Border.all(width: 1, color: Palette.primary)),
                  alignment: Alignment.center,
                  child: Text(
                    "${clinic.number}",
                    style: TextStyle(
                        color: controller.getColorTextClinic(index),
                        fontSize: 13),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(width: 10),
        );
      }),
    );
  }

  SizedBox _headerWidget() {
    return SizedBox(
      height: 40,
      child: Obx(() {
        if (_controller.isLoadingSec.value) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  decoration: const BoxDecoration(
                      color: Palette.primaryLight,
                      borderRadius: BorderRadius.all(Radius.circular(17))),
                  child: Container(
                    width: 108,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(17)),
                        border: Border.all(width: 1, color: Colors.white)),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(width: 10),
            ),
          );
        }
        return ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: _controller.sections.length,
          itemBuilder: (context, index) {
            final section = _controller.sections[index];
            return InkWell(
              onTap: () {
                _controller.changeColorSection(index);
                _controller.getClinics(section.id);
              },
              borderRadius: const BorderRadius.all(Radius.circular(17)),
              splashColor: Palette.primaryLight,
              child: Container(
                width: 108,
                decoration: BoxDecoration(
                    color: _controller.getColorButtonsSection(index),
                    borderRadius: const BorderRadius.all(Radius.circular(17)),
                    border: Border.all(width: 1, color: Palette.primary)),
                alignment: Alignment.center,
                child: Text(
                  section.name,
                  style: TextStyle(
                      color: _controller.getColorTextSection(index),
                      fontSize: 13),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(width: 10),
        );
      }),
    );
  }
}

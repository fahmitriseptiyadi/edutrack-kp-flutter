import 'package:edutrack/app/modules/nilaiujian/views/nilaiujian_view.dart';
import 'package:edutrack/app/config/edu_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/nilaiujian_controller.dart';

class NilaiUasView extends GetView<NilaiujianController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.to(() => NilaiujianView());
            // Get.offAll(HomeView());
            // Get.back();
          },
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25.0),
          ),
        ),
        backgroundColor: greendarkColor, // Set the app bar color to green
        title: Text(
          "Ujian Akhir Semester",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ), // Set the font size to 14
        ),
      ),
    );
  }
}

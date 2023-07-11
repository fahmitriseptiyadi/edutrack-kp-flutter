// import 'package:edutrack/app/modules/nilaiujian/controllers/nilaiujian_controller.dart';
import 'package:edutrack/app/modules/nilaiujian/views/nilaiujian_view.dart';
import 'package:flutter/material.dart';

import '../controllers/nilaiujian_controller.dart';

import 'package:get/get.dart';

import '../../../../constants.dart';

class KuisView extends GetView<NilaiujianController> {
  @override
  Widget build(BuildContext context) {
    final NilaiujianController _controller = Get.put(NilaiujianController());
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
          "Kuis",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ), // Set the font size to 14
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20.0),
        child: ListView.builder(
          itemCount: 1, // Display a single item
          itemBuilder: (context, index) {
            return Center(
              child: Obx(() {
                if (_controller.score.value == 0.0) {
                  return CircularProgressIndicator();
                } else {
                  return Text(
                    'Score: ${_controller.score.value.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 16),
                    
                  );
                }
              }),
            );
          },
        ),
      ),
    );
  }
}

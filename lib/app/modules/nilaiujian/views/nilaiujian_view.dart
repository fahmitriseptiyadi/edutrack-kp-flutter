// import 'package:edutrack/app/modules/home/views/home_view.dart';
import 'package:edutrack/app/modules/home/views/home_view.dart';
import 'package:edutrack/app/modules/nilaiujian/views/kuis_view.dart';
import 'package:edutrack/app/modules/nilaiujian/views/nilai_uas_view.dart';
import 'package:edutrack/app/modules/nilaiujian/views/nilai_uts_view.dart';
import 'package:edutrack/app/modules/nilaiujian/views/ulangan_view.dart';
import 'package:edutrack/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/nilaiujian_controller.dart';

class NilaiujianView extends GetView<NilaiujianController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Get.to(() => HomeView());
            print('Ikon Back Pressed');
            Get.offAll(HomeView());
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
          "Nilai Ujian",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ), // Set the font size to 14
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0), // Add spacing around the GridView
        child: GridView.count(
          crossAxisCount: 2, // Number of columns in the grid
          childAspectRatio:
              1, // Adjust the aspect ratio to make the cards smaller
          mainAxisSpacing: 16, // Add vertical spacing between grid items
          crossAxisSpacing: 16, // Add horizontal spacing between grid items
          children: [
            GridItem(
              title: 'Ujian Tengah Semester',
              date: '20 Juli 2023',
              onTap: () {
                // Action when Ujian Tengah Semester is tapped
                // Navigate to a specific page
                print('UTS Scores Page Pressed');

                Get.to(() => NilaiUtsView());
              },
            ),
            GridItem(
              title: 'Ujian Akhir Semester',
              date: '10 Desember 2023',
              onTap: () {
                // Action when Ujian Akhir Semester is tapped
                // Navigate to a specific page
                print('UAS Scores Page Pressed');

                Get.to(() => NilaiUasView());
              },
            ),
            GridItem(
              title: 'Kuis',
              date: '5 September 2023',
              onTap: () {
                // Action when Kuis is tapped
                // Navigate to a specific page
                // Get.to(() => nilai_kuis());
                print('Kuis Scores Page Pressed');
                showWaitSnackbar();

                Get.offAll(KuisView());
              },
            ),
            GridItem(
              title: 'Ulangan',
              date: '15 November 2023',
              onTap: () {
                // Action when Ulangan is tapped
                // Navigate to a specific page
                print('Ulangan Scores Page Pressed');
                Get.to(() => UlanganView());
              },
            ),
          ],
        ),
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final String title;
  final String date;
  final Function()? onTap;

  const GridItem({
    required this.title,
    required this.date,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, // Adjust the width of the card
      height: 150,

      child: Card(
        elevation: 4, // Ketinggian bayangan card
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        color: greyColor,
        child: InkWell(
          onTap: onTap, // Set the onTap action for the InkWell
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

showWaitSnackbar() async {
  Get.snackbar(
    'Wait',
    'Fetching data...',
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: greenColor,
    colorText: whiteColor,
  );
}

import 'package:edutrack/app/modules/nilaiujian/views/nilaiujian_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants.dart';
import '../controllers/home_controller.dart';

final HomeController homeController = Get.put(HomeController());

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _upBarBody(),
      bottomNavigationBar: Obx(
        () => BottomAppBar(
          notchMargin: 10,
          color: greyColor,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home,
                    color: controller.currentPage.value == 0
                        ? Colors.green
                        : Colors.black),
                onPressed: () {
                  controller.changePage(0);
                },
              ),
              IconButton(
                icon: Icon(Icons.note_rounded,
                    color: controller.currentPage.value == 1
                        ? Colors.green
                        : Colors.black),
                onPressed: () {
                  controller.changePage(1);
                },
              ),
              IconButton(
                icon: Icon(Icons.people,
                    color: controller.currentPage.value == 2
                        ? Colors.green
                        : Colors.black),
                onPressed: () {
                  controller.changePage(2);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _upBarBody() {
  return LayoutBuilder(
    builder: (context, constraints) {
      return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight * 0.2,
              padding: EdgeInsets.fromLTRB(0, 20.0, 0, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0),
                ),
                color: greendarkColor,
              ),
              child: Row(
                children: [
                  Container(
                    width: constraints.maxWidth * 0.3,
                    height: constraints.maxHeight * 0.08,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: whiteColor,
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(height: 20),
                      Container(
                        alignment: Alignment.centerLeft,
                        width: constraints.maxWidth * 0.7,
                        height: constraints.maxHeight * 0.03,
                        child: Text(
                          'Assalamualaikum, Orang tua/Wali',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                      Container(
                        width: constraints.maxWidth * 0.7,
                        height: constraints.maxHeight * 0.03,
                        child: Text(
                          'Fahmi',
                          style: TextStyle(
                            color: whiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 30.0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                'Kelas',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            SizedBox(width: 40.0),
                            Container(
                              width: 60,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 157, 219, 138),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Obx(() {
                                return DropdownButton<String>(
                                  padding: EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                                  value: homeController.selectedClass.value,
                                  onChanged: (newValue) {
                                    homeController.selectedClass.value =
                                        newValue!;
                                  },
                                  isExpanded: true,
                                  style: TextStyle(
                                    color: const Color.fromARGB(255, 2, 65, 2),
                                    fontSize: 15,
                                  ),
                                  items: homeController.classes
                                      .map<DropdownMenuItem<String>>(
                                        (String value) =>
                                            DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0),
                      // Container(
                      //   margin: EdgeInsets.fromLTRB(0, 0, 30.0, 0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Container(
                      //         child: Text(
                      //           'Tahun Ajaran',
                      //           style: TextStyle(
                      //             color: Colors.white,
                      //             fontSize: 10,
                      //           ),
                      //         ),
                      //       ),
                      //       SizedBox(width: 40.0),
                      //       Container(
                      //         width: 60,
                      //         height: 20,
                      //         decoration: BoxDecoration(
                      //           color: Color.fromARGB(255, 157, 219, 138),
                      //           borderRadius: BorderRadius.circular(20.0),
                      //         ),
                      //         child: Obx(() {
                      //           return DropdownButton<String>(
                      //             padding: EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                      //             value: homeController.selectedYear.value,
                      //             onChanged: (newValue) {
                      //               homeController.selectedYear.value =
                      //                   newValue!;
                      //             },
                      //             isExpanded: true,
                      //             style: TextStyle(
                      //               color: const Color.fromARGB(255, 2, 65, 2),
                      //               fontSize: 15,
                      //             ),
                      //             items: homeController.years
                      //                 .map<DropdownMenuItem<String>>(
                      //                   (String value) =>
                      //                       DropdownMenuItem<String>(
                      //                     value: value,
                      //                     child: Text(
                      //                       value,
                      //                       textAlign: TextAlign.center,
                      //                     ),
                      //                   ),
                      //                 )
                      //                 .toList(),
                      //           );
                      //         }),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 200),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              padding: EdgeInsets.all(16),
              children: [
                // ! Baris pertama
                IconItem(
                  icon: Icons.wallet,
                  label: 'Biaya Sekolah',
                  onTap: () {
                    // Logika atau aksi yang ingin dilakukan saat ikon Home ditekan
                    print('Ikon baiya sekolah ditekan');
                  },
                ),
                IconItem(
                  icon: Icons.alarm,
                  label: 'Kehadiran',
                  onTap: () {
                    // Logika atau aksi yang ingin dilakukan saat ikon Home ditekan
                    print('Ikon kehadiran ditekan');
                  },
                ),
                IconItem(
                  icon: Icons.stacked_bar_chart,
                  label: 'Progress',
                  onTap: () {
                    // Logika atau aksi yang ingin dilakukan saat ikon Home ditekan
                    print('Ikon progress ditekan');
                  },
                ),

                // !Baris kedua
                IconItem(
                  icon: Icons.book,
                  label: 'Nilai Ujian',
                  onTap: () {
                    // Logika atau aksi yang ingin dilakukan saat ikon Home ditekan
                    Get.to(() => NilaiujianView());
                    print('Ikon nilai ujian ditekan');
                  },
                ),
                IconItem(
                  icon: Icons.school_rounded,
                  label: 'eRapor',
                  onTap: () {
                    // Logika atau aksi yang ingin dilakukan saat ikon Home ditekan
                    print('Ikon eRapor ditekan');
                  },
                ),
                IconItem(
                  icon: Icons.edit_square,
                  label: 'Tugas',
                  onTap: () {
                    // Logika atau aksi yang ingin dilakukan saat ikon Home ditekan
                    print('Ikon tugas ditekan');
                  },
                ),

                // !Baris ketiga
                IconItem(
                  icon: Icons.calendar_month_rounded,
                  label: 'Jadwal Pelajaran',
                  onTap: () {
                    // Logika atau aksi yang ingin dilakukan saat ikon Home ditekan
                    print('Ikon jadwal pelajaran ditekan');
                  },
                ),
                IconItem(
                  icon: Icons.chat_rounded,
                  label: 'Lembar Komunikasi',
                  onTap: () {
                    // Logika atau aksi yang ingin dilakukan saat ikon Home ditekan
                    print('Ikon lembar komunikasi ditekan');
                  },
                ),
                IconItem(
                  icon: Icons.volume_up,
                  label: 'Pengumuman',
                  onTap: () {
                    // Logika atau aksi yang ingin dilakukan saat ikon Home ditekan
                    print('Ikon pengumuman ditekan');
                  },
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

class IconItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function()? onTap;

  IconItem({required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // Menggunakan onTap yang diterima dari constructor
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: greyColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // Warna bayangan
                  spreadRadius: 2, // Penyebaran bayangan
                  blurRadius: 4, // Kekaburan bayangan
                  offset: Offset(0, 2), // Posisi bayangan (x, y)
                ),
              ],
            ),
            child: Icon(icon, size: 50, color: Colors.black),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(fontSize: 11, color: greendarkColor),
          ),
        ],
      ),
    );
  }
}

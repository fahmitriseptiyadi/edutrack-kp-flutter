import 'package:edutrack/app/config/edu_color.dart';
import 'package:edutrack/app/config/edu_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  // final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
        backgroundColor: Color.fromARGB(225, 255, 255, 255),
        body: _body(mediaQuery));
  }

  Widget _body(MediaQueryData mediaQuery) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Column(
            children: [
              _upheader(mediaQuery),
              _banner(mediaQuery),
              _gridview(mediaQuery),
              Obx(() {
                return _bottomnavbar(mediaQuery);
              })
            ],
          ),
        );
      },
    );
  }

  Widget _upheader(MediaQueryData mediaQuery) {
    return Container(
      height: mediaQuery.size.height * 0.2,
      padding: EdgeInsets.only(
          top: mediaQuery.size.height * 0.03,
          left: mediaQuery.size.width * 0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(mediaQuery.size.width * 0.06),
          bottomRight: Radius.circular(mediaQuery.size.width * 0.06),
        ),
        boxShadow: [
          BoxShadow(
            color: colorsConfEdutrack.edutrackGreyShade600,
            offset: Offset(0, 4),
            blurRadius: mediaQuery.size.width * 0.08,
          ),
        ],
        color: colorsConfEdutrack.edutrackPrimary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: mediaQuery.size.height * 0.01,
          ),
          Row(
            children: [
              _circleavatar(mediaQuery),
              SizedBox(
                width: mediaQuery.size.width * 0.03,
              ),
              _user(mediaQuery)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: SizedBox(
                  // height: mediaQuery.size.height * 0.0,
                  width: mediaQuery.size.width * 0.11,
                ),
              ),
              _classdropdown(mediaQuery),
              _yeardropdown(mediaQuery)
            ],
          )
        ],
      ),
    );
  }

  Widget _circleavatar(MediaQueryData mediaQuery) {
    return Container(
      padding: EdgeInsets.only(top: mediaQuery.size.height * 0.02),
      child: CircleAvatar(
        backgroundColor: colorsConfEdutrack.edutrackWhite,
        radius: mediaQuery.size.height * 0.04,
        child: Obx(() {
          final username = controller.studentName.value;
          final initials = username.isNotEmpty ? username.substring(0, 2) : '';
          return Text(
            initials,
            style: TextStyle(fontSize: mediaQuery.size.width * 0.08),
          );
        }),
      ),
    );
  }

  Widget _user(MediaQueryData mediaQuery) {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            width: mediaQuery.size.width * 0.5,
            child: Text(
              Constants.greeting,
              style: TextStyle(
                color: Colors.white,
                fontSize: mediaQuery.size.width * 0.03,
              ),
            ),
          ),
          SizedBox(
            height: mediaQuery.size.height * 0.006,
          ),
          Container(
              alignment: Alignment.centerLeft,
              width: mediaQuery.size.width * 0.5,
              child: Obx(() {
                final studentName = controller.studentName.value;
                return Text(
                  studentName.isNotEmpty ? studentName : 'Student Name',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: mediaQuery.size.width * 0.06,
                      fontWeight: FontWeight.bold),
                );
              })),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [],
          )
        ],
      ),
    );
  }

  Widget _classdropdown(MediaQueryData mediaQuery) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: Text(
              Constants.gradeText,
              style: TextStyle(
                  color: colorsConfEdutrack.edutrackWhite,
                  fontSize: mediaQuery.size.width * 0.03),
            ),
          ),
          SizedBox(
            width: mediaQuery.size.width * 0.03,
          ),
          Container(
            width: mediaQuery.size.width * 0.14,
            height: mediaQuery.size.height * 0.03,
            decoration: BoxDecoration(
                color: colorsConfEdutrack.edutrackWhite,
                borderRadius:
                    BorderRadius.circular(mediaQuery.size.width * 0.06)),
            child: Obx(() {
              return DropdownButton<String>(
                  padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                  value: controller.selectedClass.value,
                  onChanged: (newValue) {
                    controller.selectedClass.value = newValue!;
                  },
                  isExpanded: true,
                  items: controller.classes
                      .map<DropdownMenuItem<String>>(
                          (String value) => DropdownMenuItem(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      color: colorsConfEdutrack.edutrackBlack,
                                      fontSize: mediaQuery.size.width * 0.03),
                                ),
                              ))
                      .toList());
            }),
          )
        ],
      ),
    );
  }

  Widget _yeardropdown(MediaQueryData mediaQuery) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: Text(
              Constants.periodText,
              style: TextStyle(
                  color: colorsConfEdutrack.edutrackWhite,
                  fontSize: mediaQuery.size.width * 0.03),
            ),
          ),
          SizedBox(
            width: mediaQuery.size.width * 0.03,
          ),
          Container(
            width: mediaQuery.size.width * 0.24,
            height: mediaQuery.size.height * 0.03,
            decoration: BoxDecoration(
                color: colorsConfEdutrack.edutrackWhite,
                borderRadius:
                    BorderRadius.circular(mediaQuery.size.width * 0.06)),
            child: Obx(() {
              return DropdownButton<String>(
                  padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                  value: controller.selectedYear.value,
                  onChanged: (newValue) {
                    controller.selectedYear.value = newValue!;
                  },
                  isExpanded: true,
                  items: controller.years
                      .map<DropdownMenuItem<String>>(
                          (String value) => DropdownMenuItem(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: mediaQuery.size.width * 0.03),
                                ),
                              ))
                      .toList());
            }),
          )
        ],
      ),
    );
  }

  Widget _banner(MediaQueryData mediaQuery) {
    return Container(
      width: mediaQuery.size.width,
      height: mediaQuery.size.height * 0.22,
      decoration: BoxDecoration(color: Colors.transparent),
    );
  }

  Widget _gridview(MediaQueryData mediaQueary) {
    return GridView.builder(
      padding: EdgeInsets.all(mediaQueary.size.width * 0.04),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: mediaQueary.size.width * 0.06,
          mainAxisSpacing: mediaQueary.size.width * 0.08),
      itemCount: 9,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // Handle the box press event
            // print('Box ${index + 1} pressed.');
            if (index == 0) {
              //page biaya sekolah
            } else if (index == 1) {
              //page kehadiran
            } else if (index == 2) {
              //page progress
            } else if (index == 3) {
              //page nilai ujian
              Get.toNamed('/result');
            } else if (index == 4) {
              //page eRapor
            } else if (index == 5) {
              //page tugas
            } else if (index == 6) {
              //page jadwal pelajaran
            } else if (index == 7) {
              //page lembar komunikasi
            } else if (index == 8) {
              //page pengumuman
            }
          },
          child: Column(
            children: [
              Expanded(
                child: Container(
                  key: ValueKey('item_$index'),
                  decoration: BoxDecoration(
                    color: colorsConfEdutrack.edutrackWhite,
                    borderRadius:
                        BorderRadius.circular(mediaQueary.size.width * 0.06),
                    boxShadow: [
                      BoxShadow(
                        color: colorsConfEdutrack.edutrackGreyShade600,
                        offset: Offset(0, 4),
                        blurRadius: mediaQueary.size.width * 0.03,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      Constants.iconMenu[index],
                      color: colorsConfEdutrack.edutrackBlack,
                      size: mediaQueary.size.width * 0.12,
                    ),
                  ),
                ),
              ),
              SizedBox(
                  height: mediaQueary.size.height *
                      0.01), // Adjust the spacing as needed
              Text(
                Constants.itemDesc[index],
                style: TextStyle(
                  color: colorsConfEdutrack.edutrackBlack,
                  fontSize: mediaQueary.size.width * 0.03,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _bottomnavbar(MediaQueryData mediaQuery) {
    return BottomNavigationBar(
      currentIndex: controller.selectedTabIndex.value,
      onTap: (index) {
        controller.selectedTabIndex.value = index;
      },
      backgroundColor: Color.fromARGB(225, 255, 255, 255),
      selectedItemColor: Color.fromARGB(255, 2, 65, 2),
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.task), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: '')
      ],
    );
  }
}

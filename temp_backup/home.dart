import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _homeBody(),
    );
  }

  Widget _homeBody() {
    return LayoutBuilder(builder: (context, constraints) {
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
                      bottomRight: Radius.circular(25.0)),
                  color: Color.fromARGB(255, 2, 65, 2)),
              child: Row(
                children: [
                  Container(
                    width: constraints.maxWidth * 0.3,
                    height: constraints.maxHeight * 0.08,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                  ),
                  Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20)),
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
                          'Zulfa Sulthany A',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 30.0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              // width: constraints.maxWidth * 0.2,
                              // height: constraints.maxHeight * 0.02,
                              child: Text(
                                'Kelas',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  // fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Container(
                              width: constraints.maxWidth * 0.1,
                              height: constraints.maxHeight * 0.03,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 157, 219, 138),
                                  borderRadius: BorderRadius.circular(20.0)),
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
                                      color:
                                          const Color.fromARGB(255, 2, 65, 2),
                                      fontSize: 15),
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
                            SizedBox(width: 20.0),
                            Container(
                              // width: constraints.maxWidth * 0.2,
                              // height: constraints.maxHeight * 0.02,
                              child: Text(
                                'Tahun Ajaran',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  // fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Container(
                              width: constraints.maxWidth * 0.23,
                              height: constraints.maxHeight * 0.03,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 157, 219, 138),
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Obx(() {
                                return DropdownButton<String>(
                                  padding: EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                                  value: homeController.selectedYear.value,
                                  onChanged: (newValue) {
                                    homeController.selectedYear.value =
                                        newValue!;
                                  },
                                  isExpanded: true,
                                  style: TextStyle(
                                      color:
                                          const Color.fromARGB(255, 2, 65, 2),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                  items: homeController.years
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
                    ],
                  )
                ],
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: 9,
              itemBuilder: (context, index){
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Center(
                    child: Text(
                      'Item ${index + 1}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      );
    });
  }
}

import 'package:edutrack/data/datasource/preferences/app_preferences.dart';
import 'package:edutrack/data/entities/student.dart';
import 'package:edutrack/domain/usecases/student/get_data_student.dart';
import 'package:edutrack/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../../data/datasource/remote/student_remote_data_source.dart';
import '../../../../data/repositories/student/student_repository_impl.dart';

class HomeController extends GetxController {
  @override
  void onReady() {
    // TODO: implement onInit
    super.onReady();
    print('onInit initialized');
    studentData();
  }

  late final GetStudentData getStudentData;
  late final AppPreferences appPreferences;
  var selectedClass = ''.obs;
  var studentName = ''.obs;
  var parentId = ''.obs;
  var selectedYear = ''.obs;
  var studentId = ''.obs;
  var grade = ''.obs;
  var period = ''.obs;
  List<String> classes = [];
  List<String> years = [];
  var selectedTabIndex = 0.obs;
    final Dio dio = Dio();

  HomeController(this.appPreferences) {
    final studentRemoteDataSource = StudentRemoteDataSourceImpl(dio: dio);
    final studentRepositoryImpl = StudentRepositoryImpl(
      appPreferences: appPreferences,
      remoteDataSource: studentRemoteDataSource
    );
    getStudentData = GetStudentData(studentRepositoryImpl);
  }

  void parentIds(String? value) {
    parentId.value = value!;
    print('home parentId : $parentId');
  }

  String toRomanNumeral(int value) {
    final List<String> romanNumerals = [
      'I',
      'II',
      'III',
      'IV',
      'V',
      'VI',
      'VII',
      'VIII',
      'IX',
      'X',
      'XI',
      'XII',
    ];

    if (value >= 1 && value <= romanNumerals.length) {
      return romanNumerals[value - 1];
    } else {
      return '';
    }
  }

  String getFormatedPeriod(int periodValue) {
    final currentYear = periodValue.toString();
    final nextYear = (periodValue + 1).toString();
    return '$currentYear/$nextYear';
  }

  Future<void> studentData() async {
    try {
      final pId = appPreferences.idUserLogged;
      Either<Failure, Student> result = await getStudentData.execute(pId!);
      result.fold((failure) {
        print('Error : ${failure.message}');
      }, (student) {
        final gradeToRoman = appPreferences.studentGradeSelected;
        final periodToFormated = appPreferences.studentPeriodSelected;
        final String gradeRoman = toRomanNumeral(gradeToRoman as int);
        final String formatedPeriod =
            getFormatedPeriod(periodToFormated as int);
        print('Student id : ${appPreferences.studentIdSelected}');
        print('Student name : ${appPreferences.studentNameSelected}');
        print('Student grade : ${appPreferences.studentGradeSelected}');
        print('period : $formatedPeriod');
        studentName.value = appPreferences.studentNameSelected!;
        grade.value = gradeRoman;
        period.value = formatedPeriod;

        classes = [gradeRoman];
        years = [formatedPeriod];

        if (selectedClass.value.isEmpty) {
          selectedClass.value = gradeRoman;
        }
        if (selectedYear.value.isEmpty) {
          selectedYear.value = formatedPeriod;
        }
      });
    } catch (e) {
      print('Error retrieving account data: $e');
    }
  }
}

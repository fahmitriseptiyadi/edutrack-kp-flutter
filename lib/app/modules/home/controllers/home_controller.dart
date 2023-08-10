import 'package:dio/dio.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final Dio dio = Dio();
  String populateStudy = '\$populate=studyGroupIds';
  String authTokens =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6ImFjY2VzcyJ9.eyJpYXQiOjE2ODgzNTQ1MDEsImV4cCI6MTY5MDk0NjUwMSwiYXVkIjoiaHR0cHM6Ly9lZGJ4LnBpbmlzaS5pbyIsImlzcyI6ImV4cHJlc3MiLCJzdWIiOiI2MTNmOTQ4MjczN2JhZjdhNDM4MjEyNTciLCJqdGkiOiIxMDI2ZmNhYy0zNjBjLTQyOGMtOTA2ZC03OTZmMDUwYmUxNGMifQ.81pXqOaRMMMWXRjA2P0XFXFFHcokal38eSBNP_MDS8U';
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

  void parentIds(String value) {
    parentId.value = value;
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
      dio.options.headers['Content-Type'] = 'application/json';
      dio.options.headers['Authorization'] = 'Bearer $authTokens';
      final url =
          'https://edbx.pinisi.io/users?parentId=$parentId&$populateStudy';

      final accountDataResponse = await dio.get(url);
      if (accountDataResponse.statusCode == 200) {
        final studentAccount = accountDataResponse.data;
        final username = studentAccount['data'][0]['username'];
        final studentIdValue = studentAccount['data'][0]['_id'];
        final studyGroupIds = studentAccount['data'][0]['studyGroupIds'];

        if (studyGroupIds != null) {
          final studyGroup = studyGroupIds[0];
          final gradeValue = studyGroup['grade'] as int;
          final periodValue = studyGroup['period'] as int;
          final gradeRoman = toRomanNumeral(gradeValue);
          final formatedPeriod = getFormatedPeriod(periodValue);

          studentId.value = studentIdValue;
          studentName.value = username;
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

          print('Student Id : $studentId');
          print('Username : $studentName');
          print('Grade : $selectedClass');
          print('period : $selectedYear');
        } else {
          print('No study group found for the student');
        }
      } else {
        print(
            'Error retrieving account data: ${accountDataResponse.statusCode}');
      }
    } catch (e) {
      print('Error retrieving account data: $e');
    }
  }
}

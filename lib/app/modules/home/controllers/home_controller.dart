import 'package:dio/dio.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  // Dropdown Var
  var selectedClass = 'X'.obs;
  var selectedYear = '2023/2024'.obs;
  List<String> classes = ['X', 'XI', 'XII'];
  List<String> years = ['2023/2024', '2022/2023'];


  RxInt currentPage = 0.obs;
  final count = 0.obs;
  final dio = Dio();
  var parentId = ''.obs;
  String populateStudy = '\$populate-studyGroupIds';
  var studentName = ''.obs;
  var studentId = ''.obs;
  var grade = ''.obs;
  var period = ''.obs;

  void changePage(int index) {
    currentPage.value = index;
  }

  void parentIds(String value) {
    parentId.value = value;
    print("Phone parentId : $parentId");
  }

  Future<void> studentData() async {
    final authToken =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6ImFjY2VzcyJ9.eyJpYXQiOjE2ODgzNTQ1MDEsImV4cCI6MTY5MDk0NjUwMSwiYXVkIjoiaHR0cHM6Ly9lZGJ4LnBpbmlzaS5pbyIsImlzcyI6ImV4cHJlc3MiLCJzdWIiOiI2MTNmOTQ4MjczN2JhZjdhNDM4MjEyNTciLCJqdGkiOiIxMDI2ZmNhYy0zNjBjLTQyOGMtOTA2ZC03OTZmMDUwYmUxNGMifQ.81pXqOaRMMMWXRjA2P0XFXFFHcokal38eSBNP_MDS8U';
    final url =
        'https://edbx.pinisi.io/users?parentId=$parentId&$populateStudy ';
    final accountCheckResponse = await dio.get(url);

    try {
      dio.options.headers['Content-Type'] = 'application/json';
      dio.options.headers['Authorization'] = 'Bearer $authToken';
      if (accountCheckResponse.statusCode == 200) {
        final studentAccount = accountCheckResponse.data;
        final username = studentAccount['data'][0]['username'];
        final studentIdValue = studentAccount['data'][0]['_id'];
        final studyGroupIds = studentAccount['data'][0]['StudyGroupIds'];

        if (studyGroupIds != null) {
          final studyGroup = studyGroupIds[0];
          final gradeValue = studyGroup['grade'].toString();
          final periodValue = studyGroup['period'].toString();

          studentId.value = studentIdValue;
          studentName.value = username;
          grade.value = gradeValue;
          period.value = periodValue;

          print('Student ID : $studentId');
          print('Username : $studentName');
          print('Grade : $gradeValue');
          print('Period : $periodValue');
        } else {
          print('No study group fount for the student');
        }
      } else {
        print(
            'Error retrieving account data: ${accountCheckResponse.statusCode}');
      }
    } catch (e) {
      print("Error retrievig account data : $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}

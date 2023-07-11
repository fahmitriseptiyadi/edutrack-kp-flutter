import 'package:dio/dio.dart';
import 'package:edutrack/app/modules/nilaiujian/views/nilaiujian_view.dart';
import 'package:get/get.dart';
import '../../../../constants.dart';

class NilaiujianController extends GetxController {
  //TODO: Implement NilaiUjianController

  final Dio _dio = Dio();

  RxDouble score = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    showKuis();
  }

  void showKuis() async {
    try {
      _dio.options.headers['Content-type'] = 'application/json';
      final authToken =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6ImFjY2VzcyJ9.eyJpYXQiOjE2ODgzNTQ1MDEsImV4cCI6MTY5MDk0NjUwMSwiYXVkIjoiaHR0cHM6Ly9lZGJ4LnBpbmlzaS5pbyIsImlzcyI6ImV4cHJlc3MiLCJzdWIiOiI2MTNmOTQ4MjczN2JhZjdhNDM4MjEyNTciLCJqdGkiOiIxMDI2ZmNhYy0zNjBjLTQyOGMtOTA2ZC03OTZmMDUwYmUxNGMifQ.81pXqOaRMMMWXRjA2P0XFXFFHcokal38eSBNP_MDS8U';
      _dio.options.headers['Authorization'] = 'Bearer $authToken';

      // final String baseUrl = 'https://edbx.pinisi.io/';
      final response = await _dio.get(
        'https://edbx.pinisi.io/quiz-results?quizId=60de806472ab7044896c619d&studentId=60daaced8107c72c512d7734',
      );

      final responseData = response.data as Map<String, dynamic>;
      final data = responseData['data'] as List<dynamic>;
      if ( data.isNotEmpty) {
        final scoreData = data[0]['score'] as double;
        print("Score retrieved: $scoreData");
        score.value = scoreData; // Update the score value
      } else {
        // Handle empty or null data
        print("No data available");
      }
    } catch (e) {
      // Handle error
      print("Error retrieving data : $e");
      Get.snackbar(
        'Error',
        'Failed to retrieve data: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor:
            redColor, // Mengatur warna latar belakang menjadi merah
        colorText: whiteColor,
      );
      Get.offAll(NilaiujianView());
    }
  }
}
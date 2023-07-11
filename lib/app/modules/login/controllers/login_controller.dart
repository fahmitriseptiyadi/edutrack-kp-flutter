import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:edutrack/app/modules/home/controllers/home_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import 'package:edutrack/app/modules/login/user_model.dart' as LocalUser;

class LoginController extends GetxController {
  final HomeController homeController = Get.find<HomeController>();
  var parentId;

  var showPrefix = false.obs;
  var isLogin = true;
  var phoneNo = "".obs;
  var otp = "".obs;
  var isOtpSent = false.obs;
  var resendAfter = 10.obs;
  var resendOTP = true.obs;
  var firebaseVerificationId = "";
  var statusMessage = "".obs;
  var statusMessageColor = Colors.black.obs;
  final FirebaseAuth auth = FirebaseAuth.instance;
  var timer;
  LoginController() {}

  getOtp() async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+' + phoneNo.value,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) {
          firebaseVerificationId = verificationId;
          isOtpSent.value = true;
          statusMessage.value = phoneNo.value;
          print('Student Account Username' + phoneNo.value);
          startResendOtpTimer();
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      // Tangani kesalahan di sini
      print('Error sending OTP: $e');
      // Contoh penanganan kesalahan: menampilkan pesan kesalahan kepada pengguna
      statusMessage.value = "Failed to send OTP. Please try again.";
    }
  }

  verifyOTP() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      statusMessage.value = "Verifying... " + otp.value;
      // Create a PhoneAuthCredential with the code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: firebaseVerificationId, smsCode: otp.value);
      // Sign the user in (or link) with the credential
      await auth.signInWithCredential(credential);
      createAccountInApi();
      Get.offNamed(Routes.HOME);
    } catch (e) {
      statusMessage.value = "Invalid  OTP";
      statusMessageColor = Colors.red.obs;
    }
  }

  resendOtp() async {
    resendOTP.value = false;
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+' + phoneNo.value,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        firebaseVerificationId = verificationId;
        isOtpSent.value = true;
        statusMessage.value = "OTP re-sent to " + phoneNo.value;
        startResendOtpTimer();
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  startResendOtpTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (resendAfter.value != 0) {
        resendAfter.value--;
      } else {
        resendAfter.value = 10;
        resendOTP.value = true;
        timer.cancel();
      }
      update();
    });
  }

  Future<void> createAccountInApi() async {
    try {
      final dio = Dio();
      dio.options.headers['Content-Type'] = 'application/json';

      final user = auth.currentUser;
      if (user != null) {
        final phoneNumber =
            (auth.currentUser?.phoneNumber ?? '').replaceFirst('+', '');
        final email = '${phoneNumber.replaceFirst('62', '')}@gmail.com';

        final accountCheckUrl =
            'https://edbx.pinisi.io/users?phone=$phoneNumber';
        print(accountCheckUrl.toString());

        final authToken =
            'eyJhbGciOiJIUzI1NiIsInR5cCI6ImFjY2VzcyJ9.eyJpYXQiOjE2ODgzNTQ1MDEsImV4cCI6MTY5MDk0NjUwMSwiYXVkIjoiaHR0cHM6Ly9lZGJ4LnBpbmlzaS5pbyIsImlzcyI6ImV4cHJlc3MiLCJzdWIiOiI2MTNmOTQ4MjczN2JhZjdhNDM4MjEyNTciLCJqdGkiOiIxMDI2ZmNhYy0zNjBjLTQyOGMtOTA2ZC03OTZmMDUwYmUxNGMifQ.81pXqOaRMMMWXRjA2P0XFXFFHcokal38eSBNP_MDS8U';
        dio.options.headers['Authorization'] = 'Bearer $authToken';

        final accountCheckResponse = await dio.get(accountCheckUrl);
        final accountData = accountCheckResponse.data;

        if (accountData != null &&
            accountData['data'] is List &&
            accountData['data'].isNotEmpty) {
          // if (accountCheckResponse.statusCode == 200) {
          print(accountCheckResponse.statusCode.toString());
          print('Ok');

          final accountData = accountCheckResponse.data;

          if (accountData != null && accountData.isNotEmpty) {
            final data = accountData['data'][0];
            parentId = data['_id'];
            homeController.parentIds(parentId);
            homeController.studentData();
            print('Parent ID: $parentId');

            
            print('Account already exist');
            Get.toNamed('/home');
            return;
          }
        } else {
          print('Akun tidak ditemukan, silahkan buat akun baru');
        }
        final url = 'https://edbx.pinisi.io/users';
        final body = LocalUser.User(
            username: phoneNumber,
            email: email,
            //password : '123456'
            phone: phoneNumber);
        final jsonBody = jsonEncode(body.toJson());
        print('Account creation request body: $jsonBody');
        print('string $body');
        final response = await dio.post(url, data: body);
        if (response.statusCode == 200 | 201) {
          print('Successfuly created account in API');
          print(response.statusCode.toString());
        } else {
          print('Failed created account');
          print(response.statusCode.toString());
        }
      }
    } catch (e) {
      print("Error creating account in API : $e");
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}

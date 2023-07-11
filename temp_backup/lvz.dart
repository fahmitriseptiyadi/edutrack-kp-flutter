import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../routes/app_pages.dart';

class LoginController extends GetxController 
    with GetSingleTickerProviderStateMixin{
  var showPrefix = false.obs;
  var isLogin = true;
  var phoneNo = "".obs;
  var otp = "".obs;
  var isOtpSent = false.obs;
  var resendAfter = 30.obs;
  var resendOTP = false.obs;
  var firebaseVerificationId = "";
  var statusMessage = "".obs;
  var statusMessageColor = Colors.black.obs;

  var timer;

  LoginController() {}

  @override
  void onInit() {
    super.onInit();
  }

  getOtp() async {
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+62' + phoneNo.value,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        firebaseVerificationId = verificationId;
        isOtpSent.value = true;
        statusMessage.value = "OTP sent to +62" + phoneNo.value;
        startResendOtpTimer();
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  resendOtp() async {
    resendOTP.value = false;
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+62' + phoneNo.value,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        firebaseVerificationId = verificationId;
        isOtpSent.value = true;
        statusMessage.value = "OTP re-sent to +62" + phoneNo.value;
        startResendOtpTimer();
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
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
      Get.offNamed(Routes.HOME);
    } catch (e) {
      statusMessage.value = "Invalid  OTP";
      statusMessageColor = Colors.red.obs;
    }
  }

  startResendOtpTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (resendAfter.value != 0) {
        resendAfter.value--;
      } else {
        resendAfter.value = 30;
        resendOTP.value = true;
        timer.cancel();
      }
      update();
    });
  }

  

  @override
  void dispose() {
    super.dispose();
  }
}

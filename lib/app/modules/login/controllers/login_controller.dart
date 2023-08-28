import 'package:edutrack/app/modules/home/controllers/home_controller.dart';
import 'package:edutrack/data/datasource/preferences/app_preferences.dart';
import 'package:edutrack/data/datasource/remote/auth_remote_data_source.dart';
import 'package:edutrack/data/entities/auth.dart';
import 'package:edutrack/data/repositories/auth/auth_repository_impl.dart';
import 'package:edutrack/domain/usecases/auth/do_login.dart';
import 'package:edutrack/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';

class LoginController extends GetxController {
  final AppPreferences appPreferences;
  late final DoLogin doLogin;
  final HomeController homeController = Get.find<HomeController>();
  final dio = Dio();
  RxString textFieldValue = ''.obs;
  RxString otpFieldValue = ''.obs;
  TextEditingController numController = TextEditingController();
  OtpFieldController otpController = OtpFieldController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationIdReceived = '';
  bool otpSent = false;
  String uname = '';
  String pass = '';
  String? parentId = '';

  LoginController(this.appPreferences){
    final authRemoteDataSource = AuthRemoteDataSourceImpl(dio: dio);
    final authRepositoryImpl = AuthRepositoryImpl(
      appPreferences : appPreferences,
      remoteDataSource: authRemoteDataSource
    );
    doLogin = DoLogin(authRepositoryImpl);
  }

  void updateText(String value) {
    textFieldValue.value = value;
  }

  void otpUpdate(String value) {
    otpFieldValue.value = value;
  }

  Future<void> sendSms() async {
    String value = textFieldValue.value;
    await _auth.verifyPhoneNumber(
      phoneNumber: '+62$value',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential).then((value) {
          print('auth...');
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print('Verification Failed: ${e.code} - ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        verificationIdReceived = verificationId;
        otpSent = true;
        print('Verification ID: $verificationId');
        print('OTP set to true');
      },
      codeAutoRetrievalTimeout: (String verificationID) {},
    );

    print('SMS sent to: $value');
    textFieldValue.value = '';
  }

  void clearTextField() {
    numController.clear();
  }

  void clearOtpField() {
    otpController.clear();
  }
  

  void login() async {
    String otpValue = otpFieldValue.value;
    print('OTP auth: $otpValue');
    print(verificationIdReceived);
    if (otpSent) {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationIdReceived,
        smsCode: otpValue,
      );
      await _auth.signInWithCredential(credential).then((value) async {
        print('account?');

        final username = (_auth.currentUser?.phoneNumber ?? '').replaceFirst('+', '');
        print(username);
        Either<Failure, Auth> result = await doLogin.execute(username);
        result.fold(
          (failure) {
            print('error');
            print('Error : ${failure.message}');
          },
          (auth) {
            print('login');
            // final appPrefereces = AppPreferences();
            print('Access Token : ${appPreferences.tokenAcc}');
            print('Id Logged User : ${appPreferences.idUserLogged}');
            Get.toNamed('/home');
            homeController.studentData();
          }
        );
      });
    }
  }
}

import 'package:edutrack/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import 'package:get/get.dart';
// import 'package:otp_text_field/otp_field.dart';
// import 'package:otp_text_field/otp_field_style.dart';
// import 'package:otp_text_field/style.dart';

import '../controllers/login_controller.dart';

// ignore: must_be_immutable
class LoginView extends GetView<LoginController> {
  final LoginController loginController = Get.put(LoginController());
  LoginView({Key? key}) : super(key: key);
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greendarkColor,
      body: Container(
        height: MediaQuery.of(context)
            .size
            .height, // Set the container height to match the screen height
        child: ListView(
          children: [
            SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Center(
                      child: Image.asset(
                        'assets/img/logo.png',
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.2,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1,
                        vertical: MediaQuery.of(context).size.height * 0.05,
                      ),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: whiteColor,
                              ),
                            ),
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Phone number',
                              labelStyle: TextStyle(
                                color: whiteColor,
                                fontSize: 14,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      greyColor, // Add the desired color for the focused border
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: whiteColor,
                                ),
                              ),
                            ),
                            style: TextStyle(
                              color: whiteColor,
                            ),
                            keyboardType: TextInputType.phone,
                            onChanged: (val) {
                              loginController.phoneNo.value = val;
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              onPressed: () => loginController.resendOTP.value
                                  ? loginController.resendOTP()
                                  : null,
                              child: Obx(() {
                                if (loginController.resendOTP.value) {
                                  return Text(
                                    "Kirim ulang OTP",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: whiteColor,
                                    ),
                                  );
                                } else {
                                  return Text(
                                    "Wait ${loginController.resendAfter.value} s",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: blueColor,
                                    ),
                                  );
                                }
                              }),
                              style: TextButton.styleFrom(
                                alignment: Alignment.centerLeft,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 1,
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: ElevatedButton(
                              onPressed: () {
                                final form = _formKey.currentState;
                                if (form!.validate()) {
                                  form.save();
                                  loginController.getOtp();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                                backgroundColor: whiteColor,
                                // primary: whiteColor,
                                // onPrimary: greyColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.height * 0.06,
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Send OTP',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Text(
                            'Masukan kode OTP',
                            style: TextStyle(
                              fontSize: 14,
                              color: whiteColor,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Container(
                            constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.8),
                            child: OtpTextField(
                              numberOfFields: 6,
                              borderColor: whiteColor,
                              enabledBorderColor: whiteColor,
                              // Warna tepi saat input diaktifkan
                              focusedBorderColor: greyColor,

                              showFieldAsBox: false,
                              textStyle: TextStyle(color: whiteColor),
                              onSubmit: (String verificationCode) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("OTP Code"),
                                      content: Text(
                                          'Code entered is $verificationCode'),
                                    );
                                  },
                                );
                                loginController.otp.value = verificationCode;
                              },
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: ElevatedButton(
                              onPressed: () {
                                loginController.verifyOTP();
                              },
                              child: Text(
                                'LOGIN',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color?>(
                                        (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed))
                                    return const Color.fromARGB(
                                        255, 137, 180, 137);
                                  return whiteColor;
                                }),
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(
                                      width: 1,
                                      color: Colors.black,
                                    ), // Set the border width and color
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

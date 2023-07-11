import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 2, 65, 2),
      body: Container(
        height: MediaQuery.of(context).size.height, // Set the container height to match the screen height
        child: ListView(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: MediaQuery.of(context).size.height * 0.08,
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
                            'Register',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextField(
                          controller: controller.numController,
                          onChanged: (value) => controller.updateText(value),
                          decoration: InputDecoration(
                            labelText: 'Phone number',
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Kirim ulang OTP',
                            style: TextStyle(
                              fontSize: 14,
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
                            style: ElevatedButton.styleFrom(
                              elevation: 0.0,
                              backgroundColor: Colors.white,
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
                            onPressed: () {
                              controller.sendSms();
                              controller.clearTextField();
                            },
                            // onPressed: () => controller.sendSms(),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Text(
                          'Masukan kode OTP',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        OTPTextField(
                          controller: controller.otpController,
                          length: 6,
                          width: MediaQuery.of(context).size.width,
                          fieldWidth:
                              MediaQuery.of(context).size.height * 0.05,
                          otpFieldStyle: OtpFieldStyle(
                            enabledBorderColor: Colors.white,
                            focusBorderColor: Colors.grey,
                          ),
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          textFieldAlignment: MainAxisAlignment.spaceAround,
                          fieldStyle: FieldStyle.underline,
                          onChanged: (value) => controller.otpFieldValue(value),
                          // onChanged: (value) {
                          //   print('Completed : $value');
                          // },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0.0,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context)
                                          .size
                                          .height *
                                      0.06 *
                                      0.5,
                                ),
                              ),
                            ),
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () {
                              // if (controller.otpSent=true){
                              //   controller.login();
                              //   controller.clearOtpField();
                              // } else {

                              // }
                              controller.login();
                              // controller.clearOtpField();
                            },
                            // onPressed: () => controller.login(),
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        TextButton(
                          child: Text(
                            'Login'
                          ),
                          onPressed:() {
                            Get.toNamed('/login2');
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

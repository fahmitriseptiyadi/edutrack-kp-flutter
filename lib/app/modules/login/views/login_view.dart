import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:edutrack/app/config/edu_color.dart';
import 'package:edutrack/app/config/edu_constants.dart';
import 'package:edutrack/app/config/edu_text_style.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorsConfEdutrack.edutrackPrimary,
      body: Container(
        height: MediaQuery.of(context).size.height,
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
                      backgroundColor: colorsConfEdutrack.edutrackWhite,
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
                            Constants.login,
                            textAlign: TextAlign.center,
                            style: appTextStyle.login,
                          ),
                        ),
                        // CommonPhoneNumberInput(controller: controller),
                        TextField(
                          controller: controller.numController,
                          onChanged: (value) => controller.updateText(value),
                          decoration: InputDecoration(
                            labelText: Constants.phoneLabelText,
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            Constants.resendText,
                            style: appTextStyle.resendText,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height * 0.05,
                          // child: CommonSendOTPButton(controller: controller),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0.0,
                              backgroundColor: colorsConfEdutrack.edutrackWhite,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.height * 0.06,
                                ),
                              ),
                            ),
                            child: Text(
                              Constants.resendText,
                              style: appTextStyle.sendOtpText,
                            ),
                            onPressed: () {
                              controller.sendSms();
                              controller.clearTextField();
                            },
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Text(
                          Constants.otpFieldText,
                          style: appTextStyle.otp_field_text,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        // CommonOTPTextField(controller: controller),
                        OTPTextField(
                          controller: controller.otpController,
                          length: 6,
                          width: MediaQuery.of(context).size.width,
                          fieldWidth: MediaQuery.of(context).size.height * 0.05,
                          otpFieldStyle: OtpFieldStyle(
                            enabledBorderColor: colorsConfEdutrack.edutrackWhite,
                            focusBorderColor: colorsConfEdutrack.edutrackGrey,
                          ),
                          style: appTextStyle.otp_field_code,
                          textFieldAlignment: MainAxisAlignment.spaceAround,
                          fieldStyle: FieldStyle.underline,
                          onChanged: (value) => controller.otpFieldValue(value),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.05,
                          // child: CommonLoginButton(controller: controller),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0.0,
                              backgroundColor: colorsConfEdutrack.edutrackWhite,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.height *
                                      0.06 *
                                      0.5,
                                ),
                              ),
                            ),
                            child: Text(
                              Constants.login,
                              style: appTextStyle.loginButton,
                            ),
                            onPressed: () {
                              controller.login();
                            },
                          ),
                        ),
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

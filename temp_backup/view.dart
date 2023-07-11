import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/auth_controller.dart';
import '../controllers/login_controller.dart';

import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

// ignore: must_be_immutable
class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);
  final LoginController loginController = Get.put(LoginController());
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // void showPhoneNumberError() {
  //   Get.snackbar('Error', 'Please enter a phone number',
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //       margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15));
  // }
  // final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 2, 65, 2),
      body: _buildOtpBody(context),
    );
  }

  Widget _buildOtpBody(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 50.0),
                Center(
                  child: Container(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight * 0.2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Text(
                            'KP',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * 0.1,
                    vertical: constraints.maxHeight * 0.05,
                  ),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Login',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        maxLength: 12,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "(+62) Phone number",
                          labelText: "Phone number",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          prefix: loginController.showPrefix.value
                              ? Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    '(+62)',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              : null,
                          suffixIcon: AnimatedOpacity(
                            opacity: loginController.phoneNo?.value.length == 12
                                ? 1.0
                                : 0.0,
                            duration: const Duration(milliseconds: 250),
                            child: Icon(Icons.check_circle,
                                color: Colors.green, size: 15),
                          ),
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 128, 128, 128),
                          ),
                        ),
                        onChanged: (val) {
                          loginController.phoneNo.value = val;
                          loginController.showPrefix.value = val.length > 0;
                        },
                        onSaved: (val) => loginController.phoneNo.value = val!,
                        validator: (val) => (val!.isEmpty || val!.length < 10)
                            ? "Enter valid number"
                            : null,
                      ),
                      // SizedBox(height: 20.0),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () => loginController.resendOTP.value
                              ? loginController.resendOTP()
                              : null,
                          child: Text(
                            loginController.resendOTP.value
                                ? "Kirim ulang OTP"
                                : "Wait ${loginController.resendAfter} seconds",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            alignment: Alignment.centerLeft,
                          ),
                        ),
                      ),
                      SizedBox(height: 5.0),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: constraints.maxHeight * 0.05,
                      width: constraints.maxWidth * 0.8,
                      child: ElevatedButton(
                        onPressed: () {
                          final form = _formKey.currentState;
                          if (form!.validate()) {
                            form.save();
                            loginController.getOtp();
                          }
                          // _loginController.registerUser;
                        },
                        child: Text(
                          'Send OTP',
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
                              return const Color.fromARGB(255, 137, 180, 137);
                            return Colors.white;
                          }),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
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
                  ],
                ),
                SizedBox(height: 50.0),
                Center(
                  child: Text(
                    'Masukan kode OTP yang kamu terima',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.8),
                  child: OtpTextField(
                    numberOfFields: 6,
                    borderColor: Color.fromARGB(255, 3, 27, 89),
                    showFieldAsBox: false,
                    textStyle: TextStyle(color: Colors.white),
                    onSubmit: (String verificationCode) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Verification Code"),
                            content: Text('Code entered is $verificationCode'),
                          );
                        },
                      );
                      loginController.otp.value = verificationCode;
                    },
                  ),
                ),
                SizedBox(height: 60),
                Container(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: constraints.maxHeight * 0.05,
                    width: constraints.maxWidth * 0.4,
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
                            return const Color.fromARGB(255, 137, 180, 137);
                          return Colors.white;
                        }),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
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
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

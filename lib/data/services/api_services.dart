import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dio/dio.dart';
import 'package:edutrack/domain/models/user_model_1.dart' as modelUser;
import 'package:edutrack/domain/models/login_model.dart' as modelLogin;
import 'package:get/get.dart';

class ApiServices {
  final Dio dio = Dio();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String authTokens = 'eyJhbGciOiJIUzI1NiIsInR5cCI6ImFjY2VzcyJ9.eyJpYXQiOjE2ODgzNTQ1MDEsImV4cCI6MTY5MDk0NjUwMSwiYXVkIjoiaHR0cHM6Ly9lZGJ4LnBpbmlzaS5pbyIsImlzcyI6ImV4cHJlc3MiLCJzdWIiOiI2MTNmOTQ4MjczN2JhZjdhNDM4MjEyNTciLCJqdGkiOiIxMDI2ZmNhYy0zNjBjLTQyOGMtOTA2ZC03OTZmMDUwYmUxNGMifQ.81pXqOaRMMMWXRjA2P0XFXFFHcokal38eSBNP_MDS8U';

  ApiServices(Dio dio);


  Future<void> createAccountInApi() async {
    try {
      dio.options.headers['Content-Type'] = 'application/json';

      final user = _auth.currentUser;
      if (user != null) {
        final phoneNumber = (_auth.currentUser?.phoneNumber ?? '').replaceFirst('+', '');
        final email = '${phoneNumber.replaceFirst('62', '')}@gmail.com';
        final url = 'https://edbx.pinisi.io/users';

        final body = modelUser.User(
          username: phoneNumber,
          email: email,
          password: '19230712',
          phone: phoneNumber,
        );

        final jsonBody = jsonEncode(body.toJson());
        print('Account creation request body: $jsonBody');

        final response = await dio.post(url, data: body);
        if (response.statusCode == 200 | 201) {
          print('Account created in API');
          print(response.statusCode.toString());
        } else {
          print('Failed to create account in API');
          print(response.statusCode.toString());
        }
      }
    } catch (e) {
      print('Error creating account in API: $e');
    }
  }

  Future<void> loginUserApi() async {
    try {
      final phoneNumber = (_auth.currentUser?.phoneNumber ?? '').replaceFirst('+', '');
      dio.options.headers['Content-Type'] = 'application/json';
      final loginUrl = 'https://edbx.pinisi.io/authentication';
      final body = modelLogin.Login(
        username: phoneNumber,
        password: '19230712',
      ); 
      final jsonBody = jsonEncode(body.toJson());
      print('Account Login request body: $jsonBody');

      final response = await dio.post(loginUrl, data: body);
      if (response.statusCode == 200 | 201) {
        print('Login Successed');
        print(response.statusCode.toString());
        Get.toNamed('/home');
      } else {
        print('Login Failed');
        print(response.statusCode.toString());
      }
    } catch(e){
      print('Login error : $e');
    }
  }

  Future<String?> checkAccountExistence() async {
    try {
      dio.options.headers['Content-Type'] = 'application/json';
      final phoneNumber = (_auth.currentUser?.phoneNumber ?? '').replaceFirst('+', '');
      print('Check account with username: $phoneNumber');
      final accountCheckUrl = 'https://edbx.pinisi.io/users?username=$phoneNumber';
      dio.options.headers['Authorization'] = 'Bearer $authTokens';


      final accountCheckResponse = await dio.get(accountCheckUrl);
      if (accountCheckResponse.statusCode == 200) {
        final accountData = accountCheckResponse.data;
        if (accountData != null && accountData['data'] is List && accountData['data'].isNotEmpty) {
          print('Account exists');
          final data = accountData['data'][0];
          return data['_id'];
        } else {
          print('Account not found');
          return null;
        }
      } else {
        print('Failed to check account existence');
        return null;
      }
    } catch (e) {
      print('Error checking account existence: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>> getAccountData(String parentId) async {
    try {
      dio.options.headers['Content-Type'] = 'application/json';
      dio.options.headers['Authorization'] = 'Bearer $authTokens';
      final url = 'https://edbx.pinisi.io/users?parentId=$parentId&\$populate=studyGroupIds';

      final accountDataResponse = await dio.get(url);
      if (accountDataResponse.statusCode == 200) {
        print(accountDataResponse.data);
        return accountDataResponse.data;
      } else {
        throw Exception('Error retrieving account data: ${accountDataResponse.statusCode}');
      }
    } catch (e) {
      throw Exception('Error retrieving account data: $e');
    }
  }
}

import 'package:edutrack/domain/models/auth_model.dart';
import 'package:edutrack/utils/headers.dart';
import 'package:dio/dio.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> postLogin(String username);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
  
  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<AuthModel> postLogin(String username) async {
    dio.options.headers = headerPost;
    final url = 'https://edbx.pinisi.io/authentication';
    final response = await dio.post(
      url, 
      data: {
        "strategy" : "local",
        "username" : username,
        "password" : "19230712"
      },
    );
    if (response.statusCode == 201){
      final jsonData = response.data as Map<String, dynamic>;
      return AuthModel.fromJson(jsonData);
    } else {
      throw response.data['message'].toString();
    }
  }
}
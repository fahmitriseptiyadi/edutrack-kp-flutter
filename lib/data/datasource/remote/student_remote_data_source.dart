import 'package:edutrack/data/datasource/preferences/app_preferences.dart';
import 'package:edutrack/domain/models/student_model.dart';
import 'package:edutrack/utils/headers.dart';
import 'package:dio/dio.dart';

abstract class StudentRemoteDataSource {
  Future<StudentModel> getStudent(String pId);
}

class StudentRemoteDataSourceImpl implements StudentRemoteDataSource {
  final Dio dio;
  final appPreferences = AppPreferences();
  
  StudentRemoteDataSourceImpl({
    required this.dio
  });

  @override
  Future<StudentModel> getStudent(String pId) async {
    dio.options.headers = headerGet;
    dio.options.headers['Authorization'] = 'Bearer ${appPreferences.tokenAcc}';
    final url = 'https://edbx.pinisi.io/users?parentId=$pId&\$populate=studyGroupIds';
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      print('remote data check ok');
      final jsonData = response.data;
      print(jsonData);
      try {
        return StudentModel.fromJson(jsonData['data'][0]);
      } catch (e) {
        print('studentModel fromJson check fail');
        throw response.data['message'].toString();
      }
    } else {
      print('remote data check fail');
      throw response.data['message'].toString();
    }
  }
}
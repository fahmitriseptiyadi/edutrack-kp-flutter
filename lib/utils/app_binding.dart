// import 'package:app3/data/repositories/auth/auth_repository.dart';
// import 'package:app3/data/repositories/auth/auth_repository_impl.dart';
import 'package:edutrack/data/datasource/preferences/app_preferences.dart';
import 'package:edutrack/data/services/api_services.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Dio dio = Dio();

    Get.put<ApiServices>(ApiServices(dio));
    // Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find()));
    Get.put<AppPreferences>(AppPreferences());
  }
}
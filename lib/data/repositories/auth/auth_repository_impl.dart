import 'package:edutrack/data/datasource/preferences/app_preferences.dart';
import 'package:edutrack/data/datasource/remote/auth_remote_data_source.dart';
import 'package:edutrack/data/entities/auth.dart';
import 'package:edutrack/data/repositories/auth/auth_repository.dart';
import 'package:edutrack/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:get_storage/get_storage.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AppPreferences appPreferences;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.appPreferences
  });

  @override
  Future<Either<Failure, Auth>> postLogin(String username) async {
    try {
      final result = await remoteDataSource.postLogin(username);
      appPreferences.tokenAcc = result.accessToken;
      appPreferences.idUserLogged = result.user?.sId;
      return Right(result.toEntity());
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getToken() async {
    try {
      final result = appPreferences.token.val;
      return Right(result.toString());
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
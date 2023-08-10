import 'package:edutrack/data/entities/auth.dart';
import 'package:edutrack/utils/failure.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> getToken();
  Future<Either<Failure, Auth>> postLogin(String username);
}
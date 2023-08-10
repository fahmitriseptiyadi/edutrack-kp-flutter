import 'package:edutrack/data/entities/auth.dart';
import 'package:edutrack/data/repositories/auth/auth_repository.dart';
import 'package:edutrack/utils/failure.dart';
import 'package:dartz/dartz.dart';

class DoLogin {
  final AuthRepository repository;
  
  DoLogin(this.repository);

  Future<Either<Failure, Auth>> execute(String username) {
    return repository.postLogin(username);
  }
}
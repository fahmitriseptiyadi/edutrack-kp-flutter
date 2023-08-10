import 'package:edutrack/data/entities/student.dart';
import 'package:edutrack/utils/failure.dart';
import 'package:dartz/dartz.dart';

abstract class StudentRepository {
  Future<Either<Failure, Student>> getStudent(String pId);
}
import 'package:edutrack/data/entities/student.dart';
import 'package:edutrack/data/repositories/student/student_repository.dart';
import 'package:edutrack/utils/failure.dart';
import 'package:dartz/dartz.dart';

class GetStudentData {
  final StudentRepository repository;

  GetStudentData(this.repository);

  Future<Either<Failure, Student>> execute(String pId) {
    return repository.getStudent(pId);
  }
}
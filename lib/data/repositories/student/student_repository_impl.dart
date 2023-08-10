import 'package:edutrack/data/datasource/preferences/app_preferences.dart';
import 'package:edutrack/data/datasource/remote/student_remote_data_source.dart';
import 'package:edutrack/data/entities/student.dart';
import 'package:edutrack/data/repositories/student/student_repository.dart';
import 'package:edutrack/utils/failure.dart';
import 'package:dartz/dartz.dart';

class StudentRepositoryImpl implements StudentRepository {
  final StudentRemoteDataSource remoteDataSource;
  final AppPreferences appPreferences;

  StudentRepositoryImpl({
    required this.remoteDataSource,
    required this.appPreferences
  });

  @override
  Future<Either<Failure, Student>> getStudent(String pId) async {
    try {
      final result = await remoteDataSource.getStudent(pId);
      print('studen repo check ok');
      if (result.studyGroupIds != null && result.studyGroupIds!.isNotEmpty) {
        final grade = result.studyGroupIds![0].grade;
        final period = result.studyGroupIds![0].period;
        appPreferences.studentGradeSelected = grade;
        appPreferences.studentPeriodSelected = period;
      } else {
        print('No study group found');
      }
      appPreferences.studentIdSelected = result.sId;
      appPreferences.studentNameSelected = result.username;
      return Right(result.toEntity());
    } catch (e) {
      print('student repo check fail');
      return Left(Failure(e.toString()));
    }
  }
}
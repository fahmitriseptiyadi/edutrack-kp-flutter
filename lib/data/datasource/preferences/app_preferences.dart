import 'package:edutrack/utils/type_defs.dart';
import 'package:edutrack/utils/constants.dart';
import 'package:get_storage/get_storage.dart';

class AppPreferences {
  static final _box = GetStorage(Constants.storageKey);
  static final AppPreferences _instance = AppPreferences._internal();
  factory AppPreferences() => _instance;

  AppPreferences._internal();

  static const String _keyToken = 'key_token';
  static const String _keyTokenAcc = 'key_token_acc';
  static const String _keyIdUserLogged = 'key_id_user_logged';
  static const String _keyInstitution = 'key_institution';
  static const String _keyStudentIdSelected = 'key_student_id_selected';
  static const String _keyStudentNameSelected = 'key_student_name_selected';
  static const String _keyStudentGradeSelected = 'key_student_grade_selected';
  static const String _keyStudentPeriodSelected = 'key_student_Period_selected';


  String? get token => _box.read(_keyToken) as String?;

  get accessToken => null;
  set token(String? value) => _box.write(_keyToken, value);

  String? get tokenAcc => _box.read(_keyTokenAcc) as String?;
  set tokenAcc(String? value) => _box.write(_keyTokenAcc, value);

  String? get idUserLogged => _box.read(_keyIdUserLogged) as String?;
  set idUserLogged(String? value) => _box.write(_keyIdUserLogged, value);

  String? get idInstitutionStudent => _box.read(_keyInstitution) as String?;
  set idInstitutionStudent(String? value) => _box.write(_keyInstitution, value);

  String? get studentIdSelected => _box.read(_keyStudentIdSelected) as String?;
  set studentIdSelected(String? value) => _box.write(_keyStudentIdSelected, value);

  String? get studentNameSelected => _box.read(_keyStudentNameSelected) as String?;
  set studentNameSelected(String? value) => _box.write(_keyStudentNameSelected, value);
  
  int? get studentGradeSelected => _box.read(_keyStudentGradeSelected) as int?;
  set studentGradeSelected(int? value) => _box.write(_keyStudentGradeSelected, value);

  int? get studentPeriodSelected => _box.read(_keyStudentPeriodSelected) as int?;
  set studentPeriodSelected(int? value) => _box.write(_keyStudentPeriodSelected, value);

  void listenTokenChange(AppPreferencesListener callback) {
    _box.listenKey(_keyToken, callback);
  }

  void listenTokenAccChange(AppPreferencesListener callback) {
    _box.listenKey(_keyTokenAcc, callback);
  }

  void listenIdUserLoggedChange(AppPreferencesListener callback) {
    _box.listenKey(_keyIdUserLogged, callback);
  }

  void listenInstitutionChange(AppPreferencesListener callback) {
    _box.listenKey(_keyInstitution, callback);
  }

  void listenStudentIdSelectedChange(AppPreferencesListener callback) {
    _box.listenKey(_keyStudentIdSelected, callback);
  }
  void listenStudentNameSelectedChange(AppPreferencesListener callback) {
    _box.listenKey(_keyStudentNameSelected, callback);
  }
}

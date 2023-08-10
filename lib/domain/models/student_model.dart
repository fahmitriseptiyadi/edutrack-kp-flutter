import 'package:edutrack/data/entities/student.dart';

class StudentModel {
  String? sId;
  List<int>? role;
  String? status;
  List<String>? enrollmentIds;
  List<String>? deviceIds;
  List<String>? studentAtInstitutionIds;
  List<String>? teacherAtInstitutionIds;
  List<String>? adminAtInstitutionIds;
  List<StudyGroupIds>? studyGroupIds;
  List<String>? institutionIds;
  List<String>? badges;
  dynamic createdBy;
  String? updatedBy;
  String? parentId;
  String? username;
  String? email;
  String? password;
  String? phone;
  bool? isVerified;
  String? verifyExpires;
  String? verifyToken;
  String? verifyShortToken;
  String? createdAt;
  String? updatedAt;
  int? iV;

  StudentModel(
      {this.sId,
      this.role,
      this.status,
      this.enrollmentIds,
      this.deviceIds,
      this.studentAtInstitutionIds,
      this.teacherAtInstitutionIds,
      this.adminAtInstitutionIds,
      this.studyGroupIds,
      this.institutionIds,
      this.badges,
      this.createdBy,
      this.updatedBy,
      this.parentId,
      this.username,
      this.email,
      this.password,
      this.phone,
      this.isVerified,
      this.verifyExpires,
      this.verifyToken,
      this.verifyShortToken,
      this.createdAt,
      this.updatedAt,
      this.iV});

  StudentModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    role = json['role'].cast<int>();
    status = json['status'];
    enrollmentIds = json['enrollmentIds'].cast<String>();
    deviceIds = json['deviceIds'].cast<String>();
    studentAtInstitutionIds = json['student_at_institutionIds'].cast<String>();
    teacherAtInstitutionIds = json['teacher_at_institutionIds'].cast<String>();
    adminAtInstitutionIds = json['admin_at_institutionIds'].cast<String>();
    if (json['studyGroupIds'] != null) {
      studyGroupIds = <StudyGroupIds>[];
      json['studyGroupIds'].forEach((v) {
        studyGroupIds?.add(StudyGroupIds.fromJson(v));
      });
    }
    institutionIds = json['institutionIds'].cast<String>();
    badges = json['badges'].cast<String>();
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    parentId = json['parentId'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    isVerified = json['isVerified'];
    verifyExpires = json['verifyExpires'];
    verifyToken = json['verifyToken'];
    verifyShortToken = json['verifyShortToken'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = sId;
    data['role'] = role;
    data['status'] = status;
    data['enrollmentIds'] = enrollmentIds;
    data['deviceIds'] = deviceIds;
    data['student_at_institutionIds'] = studentAtInstitutionIds;
    data['teacher_at_institutionIds'] = teacherAtInstitutionIds;
    data['admin_at_institutionIds'] = adminAtInstitutionIds;
    if (studyGroupIds != null) {
      data['studyGroupIds'] = studyGroupIds?.map((v) => v.toJson()).toList();
    }
    data['institutionIds'] = institutionIds;
    data['badges'] = badges;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['parentId'] = parentId;
    data['username'] = username;
    data['email'] = email;
    data['password'] = password;
    data['phone'] = phone;
    data['isVerified'] = isVerified;
    data['verifyExpires'] = verifyExpires;
    data['verifyToken'] = verifyToken;
    data['verifyShortToken'] = verifyShortToken;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
  Student toEntity() {
    print('toEntities check ok');
    return Student(
      sId: sId,
      studentAtInstitutionIds: studentAtInstitutionIds,
      institutionIds: institutionIds,
      username: username
    );
  }
}

class StudyGroupIds {
  String? sId;
  List<String>? lessonIds;
  String? type;
  String? createdBy;
  String? updatedBy;
  String? name;
  String? department;
  int? grade;
  int? period;
  String? curriculum;
  String? teacherId;
  String? institutionId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  StudyGroupIds(
      {this.sId,
      this.lessonIds,
      this.type,
      this.createdBy,
      this.updatedBy,
      this.name,
      this.department,
      this.grade,
      this.period,
      this.curriculum,
      this.teacherId,
      this.institutionId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  StudyGroupIds.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    lessonIds = json['lessonIds'].cast<String>();
    type = json['type'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    name = json['name'];
    department = json['department'];
    grade = json['grade'];
    period = json['period'];
    curriculum = json['curriculum'];
    teacherId = json['teacherId'];
    institutionId = json['institutionId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = sId;
    data['lessonIds'] = lessonIds;
    data['type'] = type;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['name'] = name;
    data['department'] = department;
    data['grade'] = grade;
    data['period'] = period;
    data['curriculum'] = curriculum;
    data['teacherId'] = teacherId;
    data['institutionId'] = institutionId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

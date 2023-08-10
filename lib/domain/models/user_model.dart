class User {
  String? sId;
  List<String>? role;
  List<String>? studentAtInstitutionIds;
  List<String>? teacherAtInstitutionIds;
  List<String>? adminAtInstitutionIds;
  List<String>? studyGroupIds;
  List<String>? institutionIds;
  List<String>? badges;
  String? username;
  String? email;
  String? createdAt;
  String? updatedAt;
  int? iV;

  User(
      {this.sId,
      this.role,
      this.studentAtInstitutionIds,
      this.teacherAtInstitutionIds,
      this.adminAtInstitutionIds,
      this.studyGroupIds,
      this.institutionIds,
      this.badges,
      this.username,
      this.email,
      this.createdAt,
      this.updatedAt,
      this.iV});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    role = json['role'].cast<String>();
    studentAtInstitutionIds = json['student_at_institutionIds'].cast<String>();
    teacherAtInstitutionIds = json['teacher_at_institutionIds'].cast<String>();
    adminAtInstitutionIds = json['admin_at_institutionIds'].cast<String>();
    studyGroupIds = json['studyGroupIds'].cast<String>();
    institutionIds = json['institutionIds'].cast<String>();
    badges = json['badges'].cast<String>();
    username = json['username'];
    email = json['email'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = sId;
    data['role'] = role;
    data['student_at_institutionIds'] = studentAtInstitutionIds;
    data['teacher_at_institutionIds'] = teacherAtInstitutionIds;
    data['admin_at_institutionIds'] = adminAtInstitutionIds;
    data['studyGroupIds'] = studyGroupIds;
    data['institutionIds'] = institutionIds;
    data['badges'] = badges;
    data['username'] = username;
    data['email'] = email;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

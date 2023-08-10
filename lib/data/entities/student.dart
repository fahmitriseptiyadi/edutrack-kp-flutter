class Student {
  String? sId;
  List<String>? studentAtInstitutionIds;
  // String? studentAtInstitutionIds;
  List<String>? studyGroupIds;
  List<String>? institutionIds;
  // String? institutionIds;
  String? parentId;
  String? username;

  Student(
      {this.sId,
      this.studentAtInstitutionIds,
      this.studyGroupIds,
      this.institutionIds,
      this.parentId,
      this.username});

  Student.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    studentAtInstitutionIds = json['student_at_institutionIds'];
    studyGroupIds = json['studyGroupIds'].cast<String>();
    institutionIds = json['institutionIds'];
    parentId = json['parentId'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = sId;
    data['student_at_institutionIds'] = studentAtInstitutionIds;
    data['studyGroupIds'] = studyGroupIds;
    data['institutionIds'] = institutionIds;
    data['parentId'] = parentId;
    data['username'] = username;
    return data;
  }
}

class User {
  String? id;
  String? username;
  String? email;
  String? password;
  String? phone;
  List<int>? role;
  String? institutionIds;
  String? studyGroupIds;

  User({
    this.id,
    this.username,
    this.email,
    this.password,
    this.phone,
    this.role,
    this.institutionIds,
    this.studyGroupIds,
  }) {
    // default values if not provided
    role ??= [10];
    institutionIds ??= '60e393ddd2cea3cb3de19985';
    studyGroupIds ??= '6370a76128e0940702b1272c';
  }

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    role = json['role'].cast<int>();
    institutionIds = json['institutionIds'];
    studyGroupIds = json['studyGroupIds'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['password'] = password;
    data['phone'] = phone;
    data['role'] = role;
    data['institutionIds'] = institutionIds;
    data['studyGroupIds'] = studyGroupIds;
    return data;
  }
}

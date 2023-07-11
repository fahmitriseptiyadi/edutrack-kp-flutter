class User {
  String? parentId;
  String? username;
  String? email;
  String? password;
  String? phone;
  List<int>? role;
  String? institutionIds;
  String? studyGroupIds;

  User(
      {this.parentId,
      this.username,
      this.email,
      this.password,
      this.phone,
      this.role,
      this.institutionIds,
      this.studyGroupIds});

  User.fromJson(Map<String, dynamic> json) {
    parentId = json['parentId'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    role = [10];
    institutionIds = '60e393ddd2cea3cb3de19985';
    studyGroupIds = '6370a76128e0940702b1272c';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['parentId'] = parentId;
    data['username'] = username;
    data['email'] = email;
    data['password'] = '123456';
    data['phone'] = phone;
    data['role'] = [10];
    data['institutionIds'] = '60e393ddd2cea3cb3de19985';
    data['studyGroupIds'] = '6370a76128e0940702b1272c';
    return data;
  }
}

import 'package:edutrack/data/entities/auth.dart';
import 'package:edutrack/data/entities/user.dart';

class AuthModel {
  String? accessToken;
  Authentication? authentication;
  User? user;

  AuthModel({this.accessToken, this.authentication, this.user});

  AuthModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    authentication = json['authentication'] != null
        ? Authentication?.fromJson(json['authentication'])
        : null;
    user = json['user'] != null ? User?.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    if (authentication != null) {
      data['authentication'] = authentication?.toJson();
    }
    if (user != null) {
      data['user'] = user?.toJson();
    }
    return data;
  }
  Auth toEntity() {
    return Auth(
      accessToken: accessToken,
      authentication: authentication,
      user: user,
    );
  }
}
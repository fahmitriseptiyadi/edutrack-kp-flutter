import 'package:edutrack/data/entities/user.dart';

class Auth {
  String? accessToken;
  Authentication? authentication;
  User? user;

  Auth({this.accessToken, this.authentication, this.user});

  Auth.fromJson(Map<String, dynamic> json) {
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
}

class Authentication {
  String? strategy;
  String? accessToken;
  Payload? payload;

  Authentication({this.strategy, this.accessToken, this.payload});

  Authentication.fromJson(Map<String, dynamic> json) {
    strategy = json['strategy'];
    accessToken = json['accessToken'];
    payload =
        json['payload'] != null ? Payload?.fromJson(json['payload']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['strategy'] = strategy;
    data['accessToken'] = accessToken;
    if (payload != null) {
      data['payload'] = payload?.toJson();
    }
    return data;
  }
}

class Payload {
  int? iat;
  int? exp;
  String? aud;
  String? iss;
  String? sub;
  String? jti;

  Payload({this.iat, this.exp, this.aud, this.iss, this.sub, this.jti});

  Payload.fromJson(Map<String, dynamic> json) {
    iat = json['iat'];
    exp = json['exp'];
    aud = json['aud'];
    iss = json['iss'];
    sub = json['sub'];
    jti = json['jti'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['iat'] = iat;
    data['exp'] = exp;
    data['aud'] = aud;
    data['iss'] = iss;
    data['sub'] = sub;
    data['jti'] = jti;
    return data;
  }
}
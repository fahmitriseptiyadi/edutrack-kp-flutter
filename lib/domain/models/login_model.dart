class Login {
  String? strategy;
  String? username;
  String? password;

  Login({
    this.strategy, 
    this.username, 
    this.password
  }) {
    strategy ??= 'local';
  }

  

  Login.fromJson(Map<String, dynamic> json) {
    strategy = json['strategy'];
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['strategy'] = strategy;
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}

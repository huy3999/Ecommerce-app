class SignUpModel {
  String name;
  String username;
  String password;

  SignUpModel({this.name, this.username, this.password});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['username'] = this.username;
    data['password'] = this.password;
    return data;
  }
}
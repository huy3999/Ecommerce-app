class UserInfo {
  String name;
  String username;
  String idRole;
  String createdAt;
  String sId;
  String role;

  UserInfo(
      {this.name,
      this.username,
      this.idRole,
      this.createdAt,
      this.sId,
      this.role});

  UserInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    username = json['username'];
    idRole = json['id_role'];
    createdAt = json['created_at'];
    sId = json['_id'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['username'] = this.username;
    data['id_role'] = this.idRole;
    data['created_at'] = this.createdAt;
    data['_id'] = this.sId;
    data['role'] = this.role;
    return data;
  }
}
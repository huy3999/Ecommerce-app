class LoginResponse {
  String accessToken;
  String userEmail;

  LoginResponse(
      {this.accessToken, this.userEmail});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    userEmail = json['user_email'];
  }
}
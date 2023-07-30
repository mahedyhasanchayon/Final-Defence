class LoginData {
  final String userName;
  final String userId;
  final String accessToken;
  LoginData({
    required this.userName,
    required this.userId,
    required this.accessToken,
  });
}

class ProfileData {
  final String useremail;
  ProfileData({required this.useremail});
}

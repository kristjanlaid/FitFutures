class UserToken {
  int tokenId;

  UserToken({required this.tokenId});

  factory UserToken.fromJson(Map<String, dynamic> json) {
    return UserToken(
      tokenId: json['token_id'],
    );
  }
}

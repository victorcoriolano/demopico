class AuthTokens {
  final AccessToken accessToken;
  final RefreshToken refreshToken;
  final DateTime issuedAt;
  final DateTime expiresAt;

  AuthTokens({
    required this.accessToken,
    required this.refreshToken,
    required this.issuedAt,
    required this.expiresAt,
  });

  bool get isExpired => DateTime.now().isAfter(expiresAt);
}

class AccessToken {
  final String value;
  final DateTime expiresAt;

  AccessToken({required this.value, required this.expiresAt});

  bool get isExpired => DateTime.now().isAfter(expiresAt);
}

class RefreshToken {
  final String value;
// refresh tokens often long lived; keep metadata minimal
  RefreshToken({required this.value});
}

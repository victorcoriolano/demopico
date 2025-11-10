enum SignMethods {
  notDetermined,
  email,
  google,
  phone;

  String get name {
    switch (this) {
      case SignMethods.notDetermined:
        return 'notDetermined';
      case SignMethods.email:
        return 'email';
      case SignMethods.google:
        return 'google';
      case SignMethods.phone:
        return 'phone';
    }
  }
  factory SignMethods.fromString(String value) {
    switch (value) {
      case 'notDetermined':
        return SignMethods.notDetermined;
      case 'email':
        return SignMethods.email;
      case 'google':
        return SignMethods.google;
      case 'phone':
        return SignMethods.phone;
      default:
        return SignMethods.email;
    }
  }
}

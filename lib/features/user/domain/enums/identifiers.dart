enum Identifiers {
  email,
  vulgo;

  factory Identifiers.fromIsEmail(bool isEmail){
    return isEmail ? Identifiers.email : Identifiers.vulgo;
  }
}
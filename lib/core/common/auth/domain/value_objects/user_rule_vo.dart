enum UserRuleVO {
  anonymous,
  normalUser,
  coletivo,
}

extension UserRoleX on UserRuleVO {
  bool get isAnonymous => this == UserRuleVO.anonymous;
  bool get isNormalUser => this == UserRuleVO.normalUser;
  bool get isColetivo => this == UserRuleVO.coletivo;
}

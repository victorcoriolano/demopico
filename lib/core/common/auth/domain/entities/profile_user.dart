
class Profile {
  final String userID;
  final String displayName;
  final String? avatar;
  final String? description;
  final String? backgroundPicture;
  final List<String> connections;
  final List<String> spots;
  final List<String> favoriteSpots;
  final List<String> posts;
  final RuleProfile profileRule;


  const Profile({
    required this.userID,
    required this.displayName,
    required this.profileRule,
    this.avatar,
    this.description,
    this.backgroundPicture,
    this.connections = const [],
    this.spots = const [],
    this.favoriteSpots = const [],
    this.posts = const [],
  });


}

class ProfileFactory {

  static Profile initialFromUser(String userID, String displayName) {
    return Profile(
      userID: userID,
      displayName: displayName,
      profileRule: RuleProfile.owner,
    );
  }

  static Profile fromData(Map<String, dynamic> data) {
    return Profile(
      userID: data['userID'],
      displayName: data['displayName'],
      avatar: data['avatar'],
      description: data['description'],
      backgroundPicture: data['backgroundPicture'],
      connections: List<String>.from(data['connections'] ?? []),
      spots: List<String>.from(data['spots'] ?? []),
      favoriteSpots: List<String>.from(data['favoriteSpots'] ?? []),
      posts: List<String>.from(data['posts'] ?? []),
      profileRule: RuleProfile.fromString(data['profileRule'] ?? 'viewer'),
    );
  }

  static bool isMyProfile(Profile profile, String currentUserId) {
    return profile.userID == currentUserId;
  }
}

enum RuleProfile { 
  admin, 
  viewer, 
  owner;

  
  String get name {
    switch (this) {
      case RuleProfile.admin:
        return 'admin';
      case RuleProfile.viewer:
        return 'viewer';
      case RuleProfile.owner:
        return 'owner';
    }
  }

  factory RuleProfile.fromString(String value) {
    return RuleProfile.values.firstWhere(
      (e) => e.toString() == 'RuleProfile.$value',
      orElse: () => RuleProfile.viewer,
    );
  } 
}
 
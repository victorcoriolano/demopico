const String defaultDescription = "Skate or die";
class Profile {
  final String userID;
  final String displayName;
  final String? avatar;
  final String? description;
  final String? backgroundPicture;
  final List<String> connections;
  final List<String> spots;
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
    this.posts = const [],
  });

  Profile copyWith({
    String? userID,
    String? displayName,
    String? avatar,
    String? description,
    String? backgroundPicture,
    List<String>? connections,
    List<String>? spots,
    List<String>? posts,
    RuleProfile? profileRule,
  }) {
    return Profile(
      userID: userID ?? this.userID,
      displayName: displayName ?? this.displayName,
      avatar: avatar ?? this.avatar,
      description: description ?? this.description,
      backgroundPicture: backgroundPicture ?? this.backgroundPicture,
      connections: connections ?? this.connections,
      spots: spots ?? this.spots,
      posts: posts ?? this.posts,
      profileRule: profileRule ?? this.profileRule,
    );
  }

  Map<String, dynamic> toJson() {
  return {
    'userID': userID,
    'displayName': displayName,
    'avatar': avatar,
    'description': description,
    'backgroundPicture': backgroundPicture,
    'connections': connections,
    'spots': spots,
    'posts': posts,
    'profileRule': profileRule.name, // Converte a enum para uma string
  };
}

    /// Null Object (profile vazio usado como default)
  static const Profile empty = Profile(
    userID: '',
    displayName: '',
    avatar: null,
    description: '',
    backgroundPicture: null,
    connections: [],
    spots: [],
    posts: [],
    profileRule: RuleProfile.viewer,
  );
}

class ProfileFactory {

  static Profile initialFromUser(String userID, String displayName, [String? avatar, ]) {
    return Profile(
      userID: userID,
      displayName: displayName,
      avatar: avatar,
      description: defaultDescription,
      backgroundPicture: null,
      connections: List.empty(),
      posts: List.empty(),
      spots: List.empty(),
      profileRule: RuleProfile.owner,
    );
  }

  static Profile fromData(Map<String, dynamic> data, String id) {
    return Profile(
      userID: data['userID'],
      displayName: data['displayName'],
      avatar: data['avatar'],
      description: data['description'],
      backgroundPicture: data['backgroundPicture'],
      connections: List<String>.from(data['connections'] ?? []),
      spots: List<String>.from(data['spots'] ?? []),
      posts: List<String>.from(data['posts'] ?? []),
      profileRule: RuleProfile.fromString(data['profileRule'] ?? 'viewer'),
    );
  }

}

enum RuleProfile { 
  viewer, 
  owner;

  
  String get name {
    switch (this) {
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
 
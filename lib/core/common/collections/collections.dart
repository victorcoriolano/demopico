enum Collections {
  connections,
  spots,
  users,
  picosFavoritados,
  denuncias,
  communique,
  comments,
  posts,
  profile;

  factory Collections.fromString(String value) {
    switch (value) {
      case 'connections':
        return Collections.connections;
      case 'spots':
        return Collections.spots;
      case 'users':
        return Collections.users;
      case 'picosFavoritados':
        return Collections.picosFavoritados;
      case 'denuncias':
        return Collections.denuncias;
      case 'communique':
        return Collections.communique;
      case 'comments':
        return Collections.comments;
      case 'posts':
        return Collections.posts;
      case 'profiles':
        return Collections.profile;
      default:
        throw Exception("Invalid Tables name");
    }
  }

  String get name {
    switch (this) {
      case Collections.spots:
        return 'spots';
      case Collections.users:
        return 'users';
      case Collections.picosFavoritados:
        return 'picosFavoritados';
      case Collections.denuncias:
        return 'denuncias';
      case Collections.communique:
        return 'communique';
      case Collections.comments:
        return 'comments';
      case Collections.posts:
        return 'posts';
      case Collections.connections:
        return 'connections';
      case Collections.profile:
        return 'profiles';
    }
  }
}
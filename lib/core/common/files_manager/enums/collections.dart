enum Collections {
  spots,
  users,
  picosFavoritados,
  denuncias,
  communique,
  comments,
  posts;

  String fromString(String value) {
    switch (value) {
      case 'spots':
        return Collections.spots.name;
      case 'users':
        return Collections.users.name;
      case 'picosFavoritados':
        return Collections.picosFavoritados.name;
      case 'denuncias':
        return Collections.denuncias.name;
      case 'communique':
        return Collections.communique.name;
      case 'comments':
        return Collections.comments.name;
      case 'posts':
        return Collections.posts.name;
      default:
        throw Exception("Invalid Tables name");
    }
  }

  String toJson() {
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
    }
  }
}
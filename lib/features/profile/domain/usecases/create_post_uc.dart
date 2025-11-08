import 'package:demopico/core/common/auth/domain/entities/coletivo_entity.dart';
import 'package:demopico/features/profile/domain/interfaces/i_notification_repository.dart';
import 'package:demopico/features/profile/domain/models/notification.dart';
import 'package:demopico/features/profile/domain/models/post.dart';
import 'package:demopico/features/profile/infra/repository/notification_repository_impl.dart';
import 'package:demopico/features/profile/infra/repository/post_repository.dart';
import 'package:flutter/material.dart';

class CreatePostUc {
  final PostRepository _postRepository;
  final INotificationRepository _notificationRepository;

  static CreatePostUc? _instance;
  static CreatePostUc get instace =>
      _instance ?? CreatePostUc(postRepository: PostRepository.getInstance);

  CreatePostUc({required PostRepository postRepository})
      : _postRepository = postRepository,
        _notificationRepository = NotificationRepositoryImpl.getInstance;

  Future<Post> execute(Post newPost, [ColetivoEntity? coletivo]) async {
    final post = await _postRepository.createPost(newPost);
    if (coletivo != null) {
      for (final member in coletivo.members) {
        debugPrint("notificando o usuario ${member.id}");
        _notificationRepository.createNotification(NotificationItem(
            type: TypeNotification.newUpdateOnCollective,
            isRead: false,
            id: "",
            userId: member.id,
            message: "Novo post no ${coletivo.nameColetivo} do ${newPost.nome}",
            timestamp: DateTime.now()));

        debugPrint(" usuario ${member.id} notificado ");
      }

      if (post.mentionedUsers.isNotEmpty) {
        for (final user in post.mentionedUsers) {
          debugPrint("notificando o usuario sobre a mensão de $user");
          _notificationRepository.createNotification(NotificationItem(
              type: TypeNotification.newPostCollective,
              isRead: false,
              id: "",
              userId: user,
              message:
                  "Você foi mencionado em um post do ${coletivo.nameColetivo}",
              timestamp: DateTime.now()));
          debugPrint(" usuario $user notificado ");
        }
      }
    }
    return post;
  }
}

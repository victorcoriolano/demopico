import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/core/common/mixins/route_profile_validator.dart';
import 'package:demopico/features/profile/presentation/view_model/network_view_model.dart';
import 'package:demopico/features/user/domain/enums/auth_state.dart';
import 'package:demopico/features/user/presentation/controllers/auth_view_model_account.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoricHorizontalList extends StatefulWidget {
  const HistoricHorizontalList({super.key});

  @override
  State<HistoricHorizontalList> createState() => _HistoricHorizontalListState();
}

class _HistoricHorizontalListState extends State<HistoricHorizontalList> {
  final List<UserIdentification> connectionsAccepted = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = context.read<AuthViewModelAccount>().user;
      switch (user) {
        case UserEntity():
          final viewModel = context.read<NetworkViewModel>();
          connectionsAccepted.addAll(viewModel.connAccepted(user.id));
        case AnonymousUserEntity():
        // do nothing
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<UserIdentification> connectionsAccepted = [];

    final theme = Theme.of(context);
    final user = context.read<AuthViewModelAccount>().user;
    switch (user) {
      case UserEntity():
        final viewModel = context.read<NetworkViewModel>();
        connectionsAccepted.addAll(viewModel.connAccepted(user.id));

        return SizedBox(
          height: 95,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: connectionsAccepted.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            padding: const EdgeInsets.symmetric(horizontal: 4),
            itemBuilder: (context, index) {
              final friend = connectionsAccepted[index];
              return GestureDetector(
                onTap: () {
                  debugPrint(
                      " Chamando a profile do user: ${friend.id} - ${friend.name}");
                  AuthState userActual =
                      AuthViewModelAccount.instance.authState;
                  RouteProfileValidator.validateRoute(userActual, friend.id);
  
                },
                child: Column(
                  children: [
                    Container(
                      width: 62,
                      height: 62,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: theme.shadowColor.withValues(alpha: 0.1),
                            blurRadius: 4,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: friend.profilePictureUrl != null
                            ? Image.network(
                                friend.profilePictureUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  color: theme.colorScheme.surfaceContainer,
                                  child: const Icon(Icons.person, size: 32),
                                ),
                              )
                            : Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      friend.name,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        );
      case AnonymousUserEntity():
        return Icon(Icons.tag_faces_rounded);
    }
  }
}

import 'package:flutter/material.dart';

class FriendsHorizontalList extends StatefulWidget {
  const FriendsHorizontalList({super.key});

  @override
  State<FriendsHorizontalList> createState() => _FriendsHorizontalListState();
}

class _FriendsHorizontalListState extends State<FriendsHorizontalList> {

  

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Exemplo temporário de dados mockados
    final friends = [];

    return SizedBox(
      height: 95,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: friends.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        itemBuilder: (context, index) {
          final friend = friends[index];
          return GestureDetector(
            onTap: () {
              // 👉 futura navegação para perfil do amigo
              // Get.toNamed(Paths.profile, arguments: friend['id']);
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
                    child: Image.network(
                      friend['avatar']!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: theme.colorScheme.surfaceContainer,
                        child: const Icon(Icons.person, size: 32),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  friend['name']!,
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
  }
}
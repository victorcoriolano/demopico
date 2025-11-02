import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/features/profile/presentation/view_model/collective_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ColetivoRequestsPage extends StatefulWidget {
  const ColetivoRequestsPage({super.key});

  @override
  State<ColetivoRequestsPage> createState() => _ColetivoRequestsPageState();
}

class _ColetivoRequestsPageState extends State<ColetivoRequestsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // TODO: context.read<CollectiveViewModel>().fetchPendingRequests();
    });
  }

  @override
  Widget build(BuildContext context) {

    // --- Simulação de dados ---
    final requests = [
      UserIdentification(id: '1', name: 'João Silva', profilePictureUrl: null),
      UserIdentification(
          id: '2',
          name: 'Maria Clara',
          profilePictureUrl: 'https://exemplo.com/foto.png'),
      UserIdentification(id: '3', name: 'Pedro Antunes', profilePictureUrl: null),
    ];
    // --- Fim da Simulação ---

    return Scaffold(
      backgroundColor: kBlack,
      appBar: AppBar(
        title: const Text('Solicitações de Entrada'),
        backgroundColor: kDarkGrey,
        foregroundColor: kWhite,
      ),
      body: Consumer<CollectiveViewModel>(
        builder: (context, vm, child) {
          // if (vm.isLoading) {
          //   return const Center(child: CircularProgressIndicator(color: kRedAccent));
          // }

          if (requests.isEmpty) {
            return const Center(
              child: Text(
                'Nenhuma solicitação pendente.',
                style: TextStyle(color: kMediumGrey, fontSize: 16),
              ),
            );
          }

          // A lista de solicitações
          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final user = requests[index];
              return _RequestTile(
                user: user,
                onAccept: () {
                  // TODO: Lógica de aceitar
                },
                onDeny: () {
                  // TODO: Lógica de recusar
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _RequestTile extends StatelessWidget {
  final UserIdentification user;
  final VoidCallback onAccept;
  final VoidCallback onDeny;

  const _RequestTile({
    required this.user,
    required this.onAccept,
    required this.onDeny,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: kDarkGrey,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: kMediumGrey,
        backgroundImage: user.profilePictureUrl != null
            ? NetworkImage(user.profilePictureUrl!)
            : null,
        child: user.profilePictureUrl == null
            ? const Icon(Icons.person, color: kWhite)
            : null,
      ),
      title: Text(
        user.name,
        style: const TextStyle(
            color: kWhite, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      // Botões de Ação (Feedback Visual Claro)
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Botão de Recusar
          IconButton(
            icon: const Icon(Icons.cancel_rounded, color: kRedAccent, size: 30),
            onPressed: onDeny,
          ),
          const SizedBox(width: 8),
          // Botão de Aceitar
          IconButton(
            icon: Icon(Icons.check_circle_rounded,
                color: Colors.green[400], size: 30),
            onPressed: onAccept,
          ),
        ],
      ),
    );
  }
}
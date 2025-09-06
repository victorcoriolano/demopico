import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/features/profile/domain/models/relationship.dart';
import 'package:demopico/features/profile/presentation/provider/network_view_model.dart';
import 'package:demopico/features/profile/presentation/widgets/search_page_widgets/connection_action_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyNetworkScreen extends StatefulWidget {
  const MyNetworkScreen({super.key});

  @override
  State<MyNetworkScreen> createState() => _MyNetworkScreenState();
}

class _MyNetworkScreenState extends State<MyNetworkScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final viewModel = context.read<NetworkViewModel>();
      await viewModel.fetchConnectionsRequests();
      await viewModel.fetchConnectionSent();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'MINHA REDE',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                  child: Text(
                'Solicitações',
                style: TextStyle(color: kWhite),
              )),
              Tab(
                  child: Text(
                'Enviados',
                style: TextStyle(color: kWhite),
              )),
            ],
          ),
        ),
        body: Consumer<NetworkViewModel>(builder: (context, viewModel, child) {
          return TabBarView(
            children: [
              ProfileList(
                  userProfiles: viewModel.connectionRequests,
                  actionType: ActionType.accept),
              ProfileList(
                  userProfiles: viewModel.connectionSent,
                  actionType: ActionType.cancel),
            ],
          );
        }),
      ),
    );
  }
}

enum ActionType {
  accept,
  cancel,
}

class ProfileList extends StatelessWidget {
  final List<ReciverRequesterBase> userProfiles;
  final ActionType actionType;

  const ProfileList(
      {super.key, required this.userProfiles, required this.actionType});

  @override
  Widget build(BuildContext context) {
    return userProfiles.isEmpty
        ? const Center(
            child: Text('Nenhum usuário encontrado'),
          )
        : ListView.builder(
            itemCount: userProfiles.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: ConnectionActionCard(
                  user: userProfiles[index],
                  actionButton: actionType == ActionType.accept
                      ? ElevatedButton(
                          onPressed: () {
                            // TODO IMPLEMENTAR ACEITAR SOLICITAÇÃO DE CONEXÃO
                          },
                          child: const Text('Aceitar'),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            // TODO IMPLEMENTAR CANCELAR SOLICITAÇÃO DE CONEXÃO
                          },
                          child: const Text('Cancelar'),
                        ),
                ),
              );
            },
          );
  }
}

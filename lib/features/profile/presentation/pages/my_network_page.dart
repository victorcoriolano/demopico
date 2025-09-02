import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/features/profile/domain/models/relationship.dart';
import 'package:demopico/features/profile/presentation/provider/network_view_model.dart';
import 'package:demopico/features/user/domain/models/user.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<NetworkViewModel>();
      viewModel.fetchConnectionsRequests();
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
              Tab(child: Text('Solicitações', style: TextStyle(color: kWhite),)),
              Tab(child: Text('Enviados', style: TextStyle(color: kWhite),)),
            ],
          ),
        ),
        body: Consumer<NetworkViewModel>(
          builder: (context, viewModel, child) {  
            return TabBarView(
              children: [
                ProfileList(userProfiles: viewModel.connectionRequests, actionType: ActionType.accept),

                ProfileList(userProfiles: viewModel.connectionSent, actionType: ActionType.cancel),
              ],
            );
          }
        ),
      ),
    );
  }
}

enum ActionType {
  accept,
  cancel,
}

class ProfileList extends StatelessWidget {
  final List<Relationship> userProfiles;
  final ActionType actionType;

  const ProfileList({super.key, required this.userProfiles, required this.actionType});


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: userProfiles.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: Text(
              userProfiles[index].name,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Condicional para exibir os botões de ação corretos
                if (actionType == ActionType.accept) 
                  ActionButton(
                    icon: Icons.check,
                    color: Colors.green,
                    tooltip: 'Aceitar',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Solicitação aceita!'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                
                  ActionButton(
                    icon: Icons.cancel,
                    color: Colors.grey,
                    tooltip: 'Cancelar',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Solicitação cancelada!'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Widget separado para o botão de ação, para evitar duplicação de código
class ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String tooltip;
  final VoidCallback onPressed;

  const ActionButton({
    super.key,
    required this.icon,
    required this.color,
    required this.tooltip,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, color: color),
      tooltip: tooltip,
      onPressed: onPressed,
    );
  }
}
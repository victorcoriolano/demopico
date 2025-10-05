import 'package:demopico/core/app/routes/app_routes.dart';
import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/core/common/widgets/snackbar_utils.dart';
import 'package:demopico/features/profile/domain/models/relationship.dart';
import 'package:demopico/features/profile/presentation/services/verify_auth_and_get_user.dart';
import 'package:demopico/features/profile/presentation/view_model/network_view_model.dart';
import 'package:demopico/features/profile/presentation/widgets/search_page_widgets/connection_action_card.dart';
import 'package:demopico/features/user/domain/enums/auth_state.dart';
import 'package:demopico/features/user/presentation/controllers/auth_view_model_account.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      final currentUser = context.read<AuthViewModelAccount>().authState;
      switch (currentUser){
        case AuthAuthenticated _: viewModel.fetchRelactionsShips(currentUser.user);
        case AuthUnauthenticated _ : Get.toNamed(Paths.login);
      } 
       
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
                          onPressed: () async {
                            final currentUser = context.read<AuthViewModelAccount>().authState;
                            final provider  = context.read<NetworkViewModel>();
                            switch (currentUser){ 
                              case AuthAuthenticated():
                                await provider.acceptConnection(userProfiles[index], currentUser.user);
                              case AuthUnauthenticated():
                                return SnackbarUtils.userNotLogged(context);
                            }
                          },
                          child: const Text('Aceitar'),
                        )
                      : ElevatedButton(
                          onPressed: () async {
                            await context.read<NetworkViewModel>().cancelRelationship(userProfiles[index]);
                          },
                          child: const Text('Cancelar'),
                        ),
                ),
              );
            },
          );
  }
}

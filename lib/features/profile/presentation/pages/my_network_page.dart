import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/core/common/widgets/snackbar_utils.dart';
import 'package:demopico/features/profile/presentation/view_model/network_view_model.dart';
import 'package:demopico/features/profile/presentation/widgets/search_page_widgets/connection_action_card.dart';
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
      final currentUser = context.read<AuthViewModelAccount>().user;
      switch (currentUser){
        case UserEntity():
          await viewModel.fetchRelactionships(currentUser);
        case AnonymousUserEntity():
          //do nothing
          
      }
      
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabNumber = Get.arguments as int?;
    return DefaultTabController(
      initialIndex: tabNumber ?? 0,
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

class ProfileList extends StatefulWidget {
  final List<UserIdentification> userProfiles;
  final ActionType actionType;

  const ProfileList(
      {super.key, required this.userProfiles, required this.actionType});

  @override
  State<ProfileList> createState() => _ProfileListState();
}

class _ProfileListState extends State<ProfileList> {

  
  @override
  Widget build(BuildContext context) {
    return widget.userProfiles.isEmpty
        ? const Center(
            child: Text('Nenhum usuário encontrado'),
          )
        : ListView.builder(
            shrinkWrap: true, 
            itemCount: widget.userProfiles.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: ConnectionActionCard(
                  user: widget.userProfiles[index],
                  actionButton: widget.actionType == ActionType.accept
                      ? ElevatedButton(
                          onPressed: () async {
                            final currentUser = context.read<AuthViewModelAccount>().user;
                            final provider  = context.read<NetworkViewModel>();
                            switch (currentUser){
                              case UserEntity():
                                await provider.acceptConnection(
                                  widget.userProfiles[index], currentUser
                                );
                              case AnonymousUserEntity():
                                // some error occourred - user not logged
                                SnackbarUtils.userNotLogged(context);
                            }
                          },
                          child: const Text('Aceitar'),
                        )
                      : ElevatedButton(
                          onPressed: () async {
                            await context.read<NetworkViewModel>().cancelRelationship(widget.userProfiles[index]);
                            setState(() {
                              widget.userProfiles.removeAt(index);  
                            });
                            
                          },
                          child: const Text('Cancelar'),
                        ),
                ),
              );
            },
          );
  }
}

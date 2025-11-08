import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/core/common/auth/domain/entities/coletivo_entity.dart';
import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/features/profile/presentation/view_model/collective_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ManageCollectivePage extends StatefulWidget {
  final ColetivoEntity coletivo;

  const ManageCollectivePage({ super.key, required this.coletivo });

  @override
  State<ManageCollectivePage> createState() => _ManageCollectivePageState();
}


class _ManageCollectivePageState extends State<ManageCollectivePage> with TickerProviderStateMixin {
  late final TabController _tabController;
  String _title = 'Requisições de entrada';

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          switch (_tabController.index) {
            case 0:
              _title = 'Requisições de entrada';
              break;
            case 1:
              _title = 'Membros';
              break;
            case 2:
              _title = 'Configurações';
              break;
          }
        });
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CollectiveViewModel>().fetchPendingRequests(widget.coletivo.entryRequests);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlack,
      appBar: AppBar(
        centerTitle: true,
        title: Text(_title),
        backgroundColor: kDarkGrey,
        foregroundColor: kWhite,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.person_add_alt_1, color: kWhite)),
            Tab(icon: Icon(Icons.group, color: kWhite)),
            Tab(icon: Icon(Icons.more_horiz, color: kWhite)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Consumer<CollectiveViewModel>(
            builder: (context, vm, child) {
              if (vm.isLoading) {
                return const Center(child: CircularProgressIndicator(color: kRedAccent));
              }
              if (vm.requests.isEmpty) {
                return const Center(
                  child: Text(
                    'Nenhuma solicitação pendente.',
                    style: TextStyle(color: kMediumGrey, fontSize: 16),
                  ),
                );
              }
              return ListView.builder(
                itemCount: vm.requests.length,
                itemBuilder: (context, index) {
                  final user = vm.requests[index];
                  return _RequestTile(
                    user: user,
                    onAccept: () => vm.acceptUserOnCollective(user),
                    onDeny: () {
                      //TODO IMPLEMENTAR RECUSAR USER NO COLETIVO 
                    },
                  );
                },
              );
            },
          ),
          
          ListView.builder(
            itemCount: widget.coletivo.members.length,
            itemBuilder: (context, index) {
              if (widget.coletivo.members[index].id == widget.coletivo.modarator.id){
                final user = widget.coletivo.members[index];
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
      
      trailing: Text("Moderador do coletivo",style: TextStyle(color: kMediumGrey),),
                );
              }
              return _MembersTile(
                user: widget.coletivo.members[index],
                onRemoveUser: () {
                  showConfirmActionsWidget(context, widget.coletivo.members[index], widget.coletivo);
                
                },
                );
            }),
          const Center(child: Text("Configurações", style: TextStyle(color: kWhite))),
        ],
      ),
    );
  }
  
  void showConfirmActionsWidget(BuildContext context, UserIdentification member, ColetivoEntity coletivo) {
    showModalBottomSheet(
      context: context,
      backgroundColor: kDarkGrey,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Remover ${member.name} do coletivo?',
                style: const TextStyle(
                  color: kWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Tem certeza de que deseja remover este membro do coletivo? Esta ação não pode ser desfeita.',
                style: const TextStyle(color: kMediumGrey, fontSize: 14),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancelar', style: TextStyle(color: kWhite)),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kRedAccent,
                    ),
                    onPressed: () {
                      //TODO IMPLEMENTAR REMOVER USER DO COLETIVO
                      Navigator.of(context).pop();
                    },
                    child: const Text('Remover', style: TextStyle(color: kWhite)),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MembersTile extends StatelessWidget {
  final UserIdentification user;
  
  final VoidCallback onRemoveUser;

  const _MembersTile({
    required this.user,
    required this.onRemoveUser,
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
      trailing: OutlinedButton(
        onPressed: onRemoveUser,
        style: OutlinedButton.styleFrom(
          foregroundColor: kWhite,
          textStyle: TextStyle(color: kWhite,fontSize: 12 )
        ),
        child:Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.close),
            SizedBox(width: 8,),
            Text("Remover do coletivo"),
          ],
        ),
        
        
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
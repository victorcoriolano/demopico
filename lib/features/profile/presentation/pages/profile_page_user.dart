import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/features/mapa/presentation/widgets/spot_info_widgets/custom_buttons.dart';
import 'package:demopico/features/profile/domain/models/profile_user.dart';
import 'package:demopico/features/profile/domain/models/relationship.dart';
import 'package:demopico/features/profile/presentation/view_model/network_view_model.dart';
import 'package:demopico/features/profile/presentation/view_objects/suggestion_profile.dart';
import 'package:demopico/features/profile/presentation/widgets/post_widgets/profile_posts_widget.dart';
import 'package:demopico/features/profile/presentation/widgets/profile_data/profile_bottom_side_data_widget.dart';
import 'package:demopico/features/profile/presentation/widgets/profile_data/profile_top_side_data_widget.dart';
import 'package:demopico/features/user/domain/enums/type_post.dart';
import 'package:demopico/features/user/presentation/controllers/auth_view_model_account.dart';
import 'package:demopico/features/user/presentation/controllers/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ProfilePageUser extends StatefulWidget {
  const ProfilePageUser({super.key});

  @override
  State<ProfilePageUser> createState() => _ProfilePageUserState();
}

class _ProfilePageUserState extends State<ProfilePageUser>
    with TickerProviderStateMixin {
  String idProfile = Get.arguments as String;
  Profile profile = Profile.empty; // profile inicia vazio - null object

  ScrollDirection? _lastDirection;
  double _accumulatedScroll = 0.0;
  double _lastOffset = 0.0;
  bool _isVisible = true;
  TypePost typePost = TypePost.post; // definindo o tipo de post
  bool _isMyFriend = false;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController bioController = TextEditingController();
  late final TabController _tabController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final userVM = context.read<AuthViewModelAccount>().user;
    switch (userVM) {
      case UserEntity():
        debugPrint("Amigos: ${userVM.profileUser.connections}");
        _isMyFriend = userVM.profileUser.connections.contains(idProfile);
        debugPrint("Este perfil é meu amigo ? $_isMyFriend");
      case AnonymousUserEntity():
        _isMyFriend = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _tabController.addListener(() {
      if (_tabController.index == 0) {
      } else if (_tabController.index == 1) {
        typePost = TypePost.fullVideo;
        setState(() {});
      } else if (_tabController.index == 2) {
        typePost = TypePost.spot;
        setState(() {});
      }

      switch (_tabController.index) {
        case 0:
          typePost = TypePost.post;
          setState(() {});
        case 1:
          typePost = TypePost.fullVideo;
          setState(() {});
        case 2:
          typePost = TypePost.spot;
          setState(() {});
        default:
          typePost = TypePost.post;
          setState(() {});
      }
    });

    _scrollController.addListener(() {
      final currentOffset = _scrollController.offset;
      final direction = _scrollController.position.userScrollDirection;
      final delta = currentOffset - _lastOffset;

      // Se mudou de direção, zera o acumulado
      if (direction != _lastDirection) {
        _accumulatedScroll = 0.0;
        _lastDirection = direction;
      }

      _accumulatedScroll += delta;

      // Scroll para baixo (esconde) — precisa acumular pelo menos 20 pixels
      if (direction == ScrollDirection.reverse && _accumulatedScroll > 10) {
        if (_isVisible) {
          setState(() {
            _isVisible = false;
          });
        }
        _accumulatedScroll = 0; // zera após acionar
      }

      // Scroll para cima (mostra) — precisa acumular pelo menos -20 pixels
      else if (direction == ScrollDirection.forward &&
          _accumulatedScroll < -2) {
        if (!_isVisible) {
          setState(() {
            _isVisible = true;
          });
        }
        _accumulatedScroll = 0; // zera após acionar
      }

      _lastOffset = currentOffset;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = context.read<ProfileViewModel>();
      await provider.fetchProfileDataByID(idProfile);
      setState(() {
        profile = provider.currentProfile;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: kRed,
        centerTitle: true,
        title: Text(
          profile.displayName,
          style: TextStyle(
              color: kWhite, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: kAlmostWhite,
      body: SafeArea(
        child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            children: [
              ProfileTopSideDataWidget(
                avatarUrl: profile.avatar,
                backgroundUrl: profile.backgroundPicture,
              ),
              ProfileBottomSideDataWidget(
                nameUser: profile.displayName,
                idUser: profile.userID,
                followers: profile.connections.length,
                contributions: profile.spots.length,
                description: profile.description ?? '',
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: (screenWidth * 0.10) / 2, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomElevatedButton(
                        onPressed: () async {
                          final userVM = context.read<AuthViewModelAccount>().user as UserEntity;
                          if (_isMyFriend){
                            userVM.profileUser.connections.remove(profile.userID);
                            profile.connections.remove(userVM.id);
                            await context.read<NetworkViewModel>().disconnectUsers(userVM.id, profile.userID);
                          } else {
                            final userToConnect = SuggestionProfile(idUser: profile.userID, name: profile.displayName, photo: profile.avatar, status: RequestConnectionStatus.pending);
                            await context.read<NetworkViewModel>().requestConnection(userToConnect, userVM);
                          }
                        }, 
                        textButton: _isMyFriend ? "Desconectar" : "Conectar"),
                    ElevatedButton.icon(
                      onPressed: () {
                        // TODO: implementar criação de chat
                      },
                      icon: Icon(Icons.chat_outlined),
                      style: CustomElevatedButton.formatation,
                      label: Text("Acessar chat"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.all(0),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(0),
                        height: screenHeight * 0.55,
                        child: ProfilePostsWidget(
                          profile: profile,
                          controller: _tabController,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
      ),
      extendBody: true,
    );
  }
}

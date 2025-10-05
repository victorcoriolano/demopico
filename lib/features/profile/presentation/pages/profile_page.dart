
import 'package:demopico/core/app/routes/app_routes.dart';
import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/core/common/widgets/back_widget.dart';
import 'package:demopico/features/profile/presentation/view_model/network_view_model.dart';
import 'package:demopico/features/profile/presentation/widgets/post_widgets/profile_posts_widget.dart';
import 'package:demopico/features/profile/presentation/widgets/profile_data/profile_bottom_side_data_widget.dart';
import 'package:demopico/features/profile/presentation/widgets/profile_data/profile_drawer_config.dart';
import 'package:demopico/features/profile/presentation/widgets/profile_data/profile_top_side_data_widget.dart';
import 'package:demopico/features/user/domain/enums/type_post.dart';
import 'package:demopico/features/user/presentation/controllers/auth_view_model_account.dart';
import 'package:demopico/features/user/presentation/controllers/auth_view_model_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late UserEntity? user;
  bool _isVisible = true;
  ScrollDirection? _lastDirection;
  double _accumulatedScroll = 0.0;
  double _lastOffset = 0.0;

  TypePost typePost = TypePost.post; // definindo o tipo de post

  final ScrollController _scrollController = ScrollController();
  final TextEditingController bioController = TextEditingController();
  late final TabController _tabController;

  void showAlertError(context, String messageError) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text('Algum erro aconteceu: $messageError'),
        actions: [
          TextButton(
            onPressed: () async {
              final provider = context.read<AuthViewModelAccount>();
              await provider.logout();
              Get.toNamed(Paths.home);
            },
            child: const Text('SAIR E DESLOGAR'),
          )
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    final currentUser = AuthViewModelAccount.instance.user;
    switch (currentUser) {
      case UserEntity():
        context.read<NetworkViewModel>().fetchSugestions(currentUser);
        user = currentUser;
      case AnonymousUserEntity():
        // do nothing
    }
    debugPrint("User no profile page: $user");
    super.didChangeDependencies();
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
    if (user == null){
      return Center(
        child: CircularProgressIndicator(),
      );
    }

        return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: kRed,
        centerTitle: true,
        title: Text(
          user!.displayName.value,
          style: TextStyle(
              color: kWhite, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        leading: CustomBackButton(
          destination: Paths.home,
          colorIcon: kWhite,
        ),
        actions: [
          Builder(builder: (context) {
            return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.settings),
                iconSize: 30,
                color: kWhite);
          }),
        ],
      ),
      drawer: MyCustomDrawer(user: user!),
      backgroundColor: kAlmostWhite,
      body: SafeArea(
        child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            children: [
              ProfileTopSideDataWidget(
                avatarUrl: user!.avatar,
                backgroundUrl: user!.profileUser.backgroundPicture,
              ),
              ProfileBottomSideDataWidget(
                followers: user!.profileUser.connections.length,
                contributions: user!.profileUser.spots.length,
                description: user!.profileUser.description ?? '',
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
                          user: user!,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          Get.toNamed(Paths.createPostPage, arguments: typePost);
        },
        tooltip: "Criar Postagem",
        child: Icon(
          typePost == TypePost.post
              ? Icons.add
              : typePost == TypePost.fullVideo
                  ? Icons.video_call
                  : Icons.map_outlined,
        ),
      ),
    );
  }
}

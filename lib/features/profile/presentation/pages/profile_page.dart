import 'package:demopico/core/app/home_page.dart';
import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/core/common/widgets/back_widget.dart';
import 'package:demopico/features/profile/presentation/pages/create_post_page.dart';
import 'package:demopico/features/profile/presentation/widgets/post_widgets/profile_posts_widget.dart';
import 'package:demopico/features/profile/presentation/widgets/profile_data/profile_bottom_side_data_widget.dart';
import 'package:demopico/features/profile/presentation/widgets/profile_data/profile_drawer_config.dart';
import 'package:demopico/features/profile/presentation/widgets/profile_data/profile_top_side_data_widget.dart';
import 'package:demopico/features/user/domain/enums/type_post.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/presentation/controllers/auth_user_provider.dart';
import 'package:demopico/features/user/presentation/controllers/user_database_provider.dart';
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
  late UserM? user;
  bool _isVisible = true;
  bool _isLoading = true;
  ScrollDirection? _lastDirection;
  double _accumulatedScroll = 0.0;
  double _lastOffset = 0.0;

  TypePost typePost = TypePost.post; // definindo o tipo de post

  final ScrollController _scrollController = ScrollController();
  final TextEditingController bioController = TextEditingController();
  late final TabController _tabController;

  void showAlertError(context, String messageError){
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Algum erro aconteceu: $messageError'),
          actions: [
            TextButton(
              onPressed: () async {
                final provider = context.read<AuthUserProvider>();
                await provider.logout();
                Get.to(() => const HomePage());
              },
              child: const Text('SAIR E DESLOGAR'),
            )
          ],
        ),
      );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUser();
    });

    _tabController = TabController(length: 3, vsync: this);

    _tabController.addListener(() {
      if (_tabController.index == 0) {
        typePost = TypePost.post;
        setState(() {});
      } else if (_tabController.index == 1) {
        typePost = TypePost.fullVideo;
        setState(() {});
      } else if (_tabController.index == 2) {
        typePost = TypePost.spot;
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

  Future<void> _loadUser() async {
    debugPrint('Loading user...');
    _isLoading =true;
    final providerAuth = Provider.of<AuthUserProvider>(context, listen: false);
    final providerDatabase =
        Provider.of<UserDatabaseProvider>(context, listen: false);

    String? uid = providerAuth.currentIdUser;

    if (uid == null) {
      debugPrint('User ID is null');
      setState(() {
        _isLoading = false;
      });
      showAlertError(context, "Não foi possível encontrar o id do user!\n Tente entrar novamente");
      return;
    }

    await providerDatabase.retrieveUserProfileData(uid);

    if (providerDatabase.user == null) {
      debugPrint('User not found even with id');
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        showAlertError(context, "Dados não encontrados na base");
      }
      return;
    } else {
      setState(() {
        user = providerDatabase.user!;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final thisUser = context.read<UserDatabaseProvider>().user;
    if(_isLoading){
      return Center(child: CircularProgressIndicator(),);
    }
    if (thisUser == null){
      return SizedBox.shrink();
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar:  AppBar(

      backgroundColor: kAlmostWhite,
      centerTitle: true,
      title: Text(thisUser.name, style: TextStyle(
        color: kBlack,
        fontSize: 22,
        fontWeight: FontWeight.bold),
      ),
      leading: CustomBackButton(destination: HomePage()),
      actions: [
        Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              }, 
              icon: const Icon(Icons.settings),
              iconSize: 30,
              color: const Color.fromARGB(255, 0, 0, 0),
            );
          }
        ),
      ],
      ),
      drawer: MyCustomDrawer(user: thisUser),
      backgroundColor: kAlmostWhite,
      body: SafeArea(
        child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            children: [
              ProfileTopSideDataWidget(
                avatarUrl: user?.pictureUrl,
                backgroundUrl: user?.backgroundPicture,
              ),
              ProfileBottomSideDataWidget(
                followers: user?.conexoes ?? 0,
                contributions: user?.picosAdicionados ?? 0,
                description: user?.description ?? '',
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
          Get.to(() => CreatePostPage(
                typePost: typePost,
              ));
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

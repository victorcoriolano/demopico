import 'package:demopico/core/app/home_page.dart';
import 'package:demopico/core/common/widgets/back_widget.dart';
import 'package:demopico/features/profile/presentation/pages/create_post_page.dart';
import 'package:demopico/features/profile/presentation/widgets/post_widgets/profile_description_widget.dart';
import 'package:demopico/features/profile/presentation/widgets/post_widgets/profile_navigator_widget.dart';
import 'package:demopico/features/profile/presentation/widgets/post_widgets/profile_posts_widget.dart';
import 'package:demopico/features/profile/presentation/widgets/post_widgets/profile_stats_widget.dart';
import 'package:demopico/features/profile/presentation/widgets/profile_configure_widget.dart';
import 'package:demopico/features/profile/presentation/widgets/profile_top_side_data_widget.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/presentation/controllers/auth_user_provider.dart';
import 'package:demopico/features/user/presentation/controllers/user_database_provider.dart';
import 'package:demopico/features/user/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with SingleTickerProviderStateMixin {
  late UserM? user;
  String? currentUserId;
  bool _isVisible = true;
  bool _isLoading = true;
  ScrollDirection? _lastDirection;
  double _accumulatedScroll = 0.0;
  double _lastOffset = 0.0;

  final ScrollController _scrollController = ScrollController();
  final TextEditingController bioController = TextEditingController();
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUser();
    });
    _tabController = TabController(length: 3, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        // Atualiza o estado quando a aba muda
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
    final providerAuth = Provider.of<AuthUserProvider>(context, listen: false);
    final providerDatabase =
        Provider.of<UserDatabaseProvider>(context, listen: false);

    String? uid = providerAuth.pegarId();

    if (uid == null) {
      debugPrint('User ID is null');
      setState(() {
        _isLoading = true;
      });

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('User not found.'),
          actions: [
            TextButton(
              onPressed: () {
                Get.to(() => const HomePage());
              },
              child: const Text('OK'),
            )
          ],
        ),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }
    currentUserId = uid;
    await providerDatabase.retrieveUserProfileData(uid);

    if (providerDatabase.user == null) {
      debugPrint('User not found');
      setState(() {
        _isLoading = true;
      });
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: const Text('User not found.'),
            actions: [
              TextButton(
                onPressed: () {
                  Get.to(() => const LoginPage());
                },
                child: const Text('OK'),
              )
            ],
          ),
        );
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

    return Scaffold(
      body: Consumer<UserDatabaseProvider>(
        builder: (context, provider, child) => SafeArea(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView(padding: const EdgeInsets.all(0), children: [
                  Container(
                    color: const Color.fromARGB(255, 236, 235, 235),
                    padding: const EdgeInsets.all(0),
                    margin: const EdgeInsets.all(0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const CustomBackButton(
                                iconSize: 30,
                                destination: HomePage(),
                              ),
                              Text(
                                user!.name ??
                                    'Nome de usuário não encontrado...',
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              ProfileConfigureWidget(
                                  bioController: bioController),
                            ],
                          ),
                        ),
                        ProfileTopSideDataWidget(
                          avatarUrl: user?.pictureUrl,
                          backgroundUrl: user?.backgroundPicture,
                        ),
                        ProfileStatsWidget(
                          followers: user?.conexoes ?? 0,
                          contributions: user?.picosAdicionados ?? 0,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(0),
                    margin: const EdgeInsets.all(0),
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        children: [
                          AnimatedOpacity(
                            opacity: _isVisible ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 400),
                            child: ProfileDescriptionWidget(
                              description: user?.description,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(0),
                            height: screenHeight * 0.53,
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
      ),
      bottomNavigationBar: ProfileNavigatorWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreatePostPage()));
        },
        tooltip: "Criar Postagem",
        child: Icon(
          _tabController.index == 0
              ? Icons.add
              : _tabController.index == 1
                  ? Icons.video_call
                  : Icons.map_outlined,
        ),
      ),
    );
  }
}

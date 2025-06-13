import 'package:demopico/core/app/home_page.dart';
import 'package:demopico/core/common/widgets/back_widget.dart';
import 'package:demopico/features/profile/presentation/widgets/post_widgets/profile_description_widget.dart';
import 'package:demopico/features/profile/presentation/widgets/post_widgets/profile_navigator_widget.dart';
import 'package:demopico/features/profile/presentation/widgets/post_widgets/profile_posts_widget.dart';
import 'package:demopico/features/profile/presentation/widgets/post_widgets/profile_stats_widget.dart';
import 'package:demopico/features/profile/presentation/widgets/profile_bottom_side_data_widget.dart';
import 'package:demopico/features/profile/presentation/widgets/profile_configure_widget.dart';
import 'package:demopico/features/profile/presentation/widgets/profile_top_side_data_widget.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/presentation/controllers/auth_user_provider.dart';
import 'package:demopico/features/user/presentation/controllers/user_database_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late UserM? user;
  String? currentUserId;
  bool _isVisible = true;
  bool _isLoading = true;
  ScrollDirection? _lastDirection;
  double _accumulatedScroll = 0.0;
  double _lastOffset = 0.0;

  final ScrollController _scrollController = ScrollController();
  final TextEditingController bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUser();
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
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadUser() async {
    final providerAuth = Provider.of<AuthUserProvider>(context, listen: false);
    final providerDatabase =
        Provider.of<UserDatabaseProvider>(context, listen: false);

    String? uid = providerAuth.pegarId();

    if (uid == null) {
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
      return;
    }
    currentUserId = uid;
    await providerDatabase.retrieveUserProfileData(uid);

    if (providerDatabase.user == null) {
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
                  Get.to(() => const HomePage());
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
              : Container(
                  padding: const EdgeInsets.all(0),
                  margin: const EdgeInsets.all(0),
                  height: double.infinity,
                  color: const Color.fromARGB(80, 243, 240, 240),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: screenHeight * 0.35,
                        padding: const EdgeInsets.all(0),
                        margin: const EdgeInsets.all(0),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
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
                        height: screenHeight * 0.54,
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
                                child: const ProfilePostsWidget(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 60,
                        padding: EdgeInsets.all(0),
                        margin: EdgeInsets.all(0),
                        child: ProfileNavigatorWidget(),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

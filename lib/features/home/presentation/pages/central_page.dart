// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:demopico/core/app/auth_wrapper.dart';
import 'package:demopico/features/home/presentation/widgets/events_bottom_sheet.dart';
import 'package:demopico/features/home/presentation/widgets/hub_upper_sheet.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/presentation/controllers/auth_user_provider.dart';
import 'package:demopico/features/user/presentation/controllers/user_database_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CentralPage extends StatefulWidget {
  const CentralPage({super.key});

  @override
  State<CentralPage> createState() => _CentralPageState();
}

class _CentralPageState extends State<CentralPage> {
  final ScrollController scrollController = ScrollController();
  UserM? user;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUser();
    });
  }

  Future<void> _loadUser() async {
    final providerData = Provider.of<UserDatabaseProvider>(context);
    final providerAuth = Provider.of<AuthUserProvider>(context);
    String? userId = providerAuth.pegarId();

    if (userId != null) {
      await providerData.retrieveUserProfileData(userId);
    }
    setState(() {
      user = providerData.user;
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<UserDatabaseProvider>(context);
    final providerAuth = Provider.of<AuthUserProvider>(context);
    String? userId = providerAuth.pegarId();
    String? userImage;

    if (userId != null) {
      providerData.retrieveUserProfileData(userId);
      UserM? user = providerData.user;
      if (user != null) userImage = user.pictureUrl;
    }

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Stack(children: [
                Container(
                    height: MediaQuery.maybeSizeOf(context)!.height * 0.9,
                    width: MediaQuery.maybeSizeOf(context)!.width,
                    decoration: BoxDecoration(
                        gradient: RadialGradient(radius: 0.8, colors: [
                      Color(0xFFD9D9D9),
                      Color(0xFFE7E7E7),
                      Color(0xFFECECEC),
                      Color(0xFFEBEBEB),
                      Color(0xFFF9F9F9)
                    ], stops: [
                      0.2,
                      0.3,
                      0.4,
                      0.5,
                      1.0
                    ])),
                    child: Center(
                        child: Row(
                      children: [
                        Icon(Icons.chevron_left, size: 64),
                        Spacer(),
                        Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()..setRotationZ(10.2),
                          child: Image.asset('assets/images/skatepico-icon.png',
                              filterQuality: FilterQuality.high,
                              width: 150,
                              height: 150),
                        ),
                        Spacer(),
                        Icon(Icons.chevron_right, size: 64),
                      ],
                    ))),
                Positioned(
                  top: 70,
                  child: SizedBox(
                    width: MediaQuery.maybeSizeOf(context)!.width,
                    height: 120,
                    child: Row(children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        verticalDirection: VerticalDirection.down,
                        children: [
                          SizedBox(width: 140),
                          ElevatedButton(
                              onPressed: null,
                              style: ButtonStyle(
                                padding:
                                    WidgetStateProperty.all<EdgeInsetsGeometry>(
                                        EdgeInsets.fromLTRB(15, 10, 15, 10)),
                                backgroundColor: WidgetStateProperty.all<Color>(
                                    Color.fromARGB(255, 255, 255, 255)),
                                shape: WidgetStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(90.0),
                                )),
                                elevation: WidgetStateProperty.all<double>(1),
                                shadowColor: WidgetStateProperty.all<Color>(
                                    Color.fromARGB(255, 0, 0, 0)),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.sunny,
                                      size: 39, color: Colors.black87),
                                  SizedBox(width: 15),
                                  Text('25°C',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black87))
                                ],
                              )),
                        ],
                      ),
                      Spacer(),
                      GestureDetector(
                          onTap: () => Get.to(
                                AuthWrapper(),
                                transition: Transition.rightToLeftWithFade,
                                duration: const Duration(milliseconds: 600),
                                curve: Curves.fastEaseInToSlowEaseOut,
                              ),
                          child: userImage == null
                              ? Icon(Icons.supervised_user_circle, size: 64)
                              : CircleAvatar(
                                  radius: 32,
                                  backgroundImage: 
                                      NetworkImage(userImage),
                                  backgroundColor: Colors.transparent)),
                    ]),
                  ),
                ),
              ]),
            ],
          ),
          HubUpperSheet(),
          EventsBottomSheet(),
        ],
      ),
    );
  }
}

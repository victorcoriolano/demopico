import 'package:demopico/features/hub/presentation/providers/hub_provider.dart';
import 'package:demopico/features/hub/presentation/widgets/communique_tile.dart';
import 'package:demopico/features/hub/presentation/widgets/input_box.dart';
import 'package:demopico/features/hub/domain/entities/communique.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/presentation/controllers/user_data_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HubPage extends StatefulWidget {
  const HubPage({super.key});

  @override
  State<HubPage> createState() => _HubPageState();
}

class _HubPageState extends State<HubPage> {
  bool isChoosingType = false;
  bool _isDonation = false;
  bool _isEvent = false;
  TypeCommunique selectedType = TypeCommunique.normal;
  UserM? user;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HubProvider>().watchCommuniques();
    });
  }

  Future<void> _handleSendAction(String message) async {
    user ??= context.read<UserDataViewModel>().user;
    await context.read<HubProvider>().postHubCommunique(message, selectedType, user!);
  }

  List<PopupMenuEntry<String>> itemBuilder(BuildContext context) {
    return [
      PopupMenuItem<String>(
        value: 'option1',
        child: Text('Opção 1'),
      ), 
      PopupMenuItem<String>(
        value: 'option2',
        child: Text('Opção 2'),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 238, 238),
      body: SafeArea(
        child: Column(
          children: [
            // =================== HEADER ===================
            Container(
              width: double.infinity,
              height: size.height * 0.12,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 107, 7, 7),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 10,
                    child: IconButton(
                      onPressed: () => Get.back(),
                      icon: const Image(
                        image: AssetImage("assets/images/icons/fist-icon.png"),
                        width: 36,
                        height: 36,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Text(
                    "HUB",
                    style: TextStyle(
                      fontFamily: 'Misfit',
                      letterSpacing: 2,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                      Positioned(
                    right: 10,
                    child: PopupMenuButton(itemBuilder: itemBuilder, 
                    icon: const Icon(Icons.arrow_drop_down_circle_sharp, color: Colors.white), 
                    color: Colors.white, 
                    ),
                  ),
                ],
              ),
            ),

            // =================== POSTS ===================
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                color: const Color.fromARGB(255, 238, 238, 238),
                child: Consumer<HubProvider>(
                  builder: (context, provider, _) {
                    if (provider.allCommuniques.isEmpty) {
                      return const Center(
                        child: Text(
                          "Nenhuma publicação ainda...",
                          style: TextStyle(color: Colors.black54),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: provider.allCommuniques.length,
                      itemBuilder: (context, index) {
                        final communique = provider.allCommuniques[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              width: 0.5,
                              color: communique.type == TypeCommunique.event
                                  ? const Color.fromARGB(255, 128, 25, 18)
                                  : Colors.black,
                            ),
                          ),
                          child: CommuniqueTile(post: communique),
                        );
                      },
                    );
                  },
                ),
              ),
            ),

            // =================== INPUT ===================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: !isChoosingType
                    ? InputBox(
                        sendAction: _handleSendAction,
                        chooseAction: () {
                          setState(() {
                            isChoosingType = true;
                          });
                        },
                      )
                    : Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 177, 177, 177),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Escolha o tipo de publicação',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    setState(() {
                                      isChoosingType = false;
                                    });
                                  },
                                )
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    const Icon(Icons.star),
                                    CupertinoSwitch(
                                      value: _isDonation,
                                      activeTrackColor: const Color(0xFF970202),
                                      inactiveTrackColor: const Color(0xFFE0E0E0),
                                      thumbColor: Colors.black,
                                      onChanged: (bool value) {
                                        setState(() {
                                          _isDonation = value;
                                          if (value) _isEvent = false;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Icon(Icons.recycling),
                                    CupertinoSwitch(
                                      value: _isEvent,
                                      activeTrackColor: const Color(0xFF970202),
                                      inactiveTrackColor: const Color(0xFFE0E0E0),
                                      thumbColor: Colors.black,
                                      onChanged: (bool value) {
                                        setState(() {
                                          _isEvent = value;
                                          if (value) _isDonation = false;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

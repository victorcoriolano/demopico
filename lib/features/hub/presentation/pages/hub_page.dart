import 'package:demopico/features/hub/domain/entities/communique.dart';
import 'package:demopico/features/hub/presentation/providers/hub_provider.dart';
import 'package:demopico/features/hub/presentation/widgets/communique_tile.dart';
import 'package:demopico/features/hub/presentation/widgets/input_box.dart';
import 'package:demopico/features/hub/presentation/widgets/servidores_card.dart';
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

class _HubPageState extends State<HubPage> with TickerProviderStateMixin {
  bool isChoosingType = false;
  bool _isDonation = false;
  bool _isEvent = false;
  TypeCommunique selectedType = TypeCommunique.normal;
  UserM? user;
  String server = 'serverGlobal';
  final servidores = [
    {
      "name": "São Paulo",
      "image": "assets/images/servidores/serverSP.jpg",
      "path": "serverSp",
    },
    {
      "name": "Zona Oeste",
      "image": "assets/images/servidores/serverZOSP.jpg",
      "path": "serverSpZonaOeste",
    },
    {
      "name": "Zona Leste",
      "image": "assets/images/servidores/serverZL.jpeg",
      "path": "serverSpZonaLeste",
    }, 
    {
      "name": "Zona Norte",
      "image": "assets/images/servidores/serverSPZN.jpg",
      "path": "serverSpZonaNorte",
    },
    {
      "name": "Zona Sul",
      "image": "assets/images/servidores/serverSPZS.jpeg",
      "path": "serverSpZonaSul",
    }
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    if (server != 'serverOutros') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<HubProvider>().watchCommuniques(server, 'mensagens');
      });
    }

    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        if (_tabController.index == 0 ) {
          setState(() {
            server = 'serverGlobal';
          });
          context.read<HubProvider>().watchCommuniques(server, 'mensagens');
        } else if (_tabController.index == 1) {
          setState(() {
            server = 'serverOutros';
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _handleSendAction(String message) async {
    user ??= context.read<UserDataViewModel>().user;
    await context
        .read<HubProvider>()
        .postHubCommunique(message, selectedType, user!, server);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(220, 238, 238, 238),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: size.height * 0.10,
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
                        width: 32,
                        height: 32,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Text(
                    "HUB",
                    style: TextStyle(
                      fontFamily: 'Misfit',
                      letterSpacing: 2,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            TabBar(
              labelColor: const Color.fromARGB(255, 107, 7, 7),
              unselectedLabelColor: Colors.black54,
              indicatorColor: const Color.fromARGB(255, 107, 7, 7),
              controller: _tabController,
              tabs: const [
                Tab(text: "Geral"),
                Tab(text: "Servidores"),
              ],
            ),

            Expanded(
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

                  return TabBarView(
                    controller: _tabController,
                    children: [
                      // Aba Geral
                      ListView.builder(
                        itemCount: provider.allCommuniques.length,
                        itemBuilder: (context, index) {
                          final communique = provider.allCommuniques[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: const BorderSide(
                                  width: 0.5,
                                  color: Color.fromARGB(255, 116, 9, 1)),
                            ),
                            child: CommuniqueTile(post: communique),
                          );
                        },
                      ),

                      // Aba Servidores
                      Container(
                        color: const Color.fromARGB(255, 207, 212, 216),
                        child: server == 'serverOutros'
                            ? Center(
                                child: ListView(
                                children: servidores
                                    .map((servidor) => ServidoresCard(
                                          serverName: servidor["name"]!,
                                          serverImage: servidor["image"]!,
                                          servidorPath: servidor["path"]!,
                                          onTap: () {
                                            setState(() {
                                              server = servidor["path"]!;
                                            });

                                            context
                                                .read<HubProvider>()
                                                .watchCommuniques(
                                                    server, 'mensagens');
                                          },
                                        ))
                                    .toList(),
                              ))
                            : ListView.builder(
                                itemCount: provider.allCommuniques.length,
                                itemBuilder: (context, index) {
                                  final communique =
                                      provider.allCommuniques[index];
                                  return Card(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: const BorderSide(
                                          width: 0.5,
                                          color:
                                              Color.fromARGB(255, 116, 9, 1)),
                                    ),
                                    child: CommuniqueTile(post: communique),
                                  );
                                },
                              ),
                      ),
                    ],
                  );
                },
              ),
            ),
          server == 'serverOutros'
              ? const SizedBox.shrink()
              :  Padding(
              padding: const EdgeInsets.all(16),
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
                        padding: const EdgeInsets.all(10),
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
                                      inactiveTrackColor:
                                          const Color(0xFFE0E0E0),
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
                                      inactiveTrackColor:
                                          const Color(0xFFE0E0E0),
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

import 'package:demopico/core/common/ui_context_extension.dart';
import 'package:demopico/features/hub/presentation/providers/hub_provider.dart';
import 'package:demopico/features/hub/presentation/widgets/communique_tile.dart';
import 'package:demopico/features/hub/presentation/widgets/input_box.dart';
import 'package:demopico/features/hub/domain/entities/communique.dart';
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
  late final db = Provider.of<HubProvider>(context, listen: false);
  late final listenDb = Provider.of<HubProvider>(context);
  bool _isEvent = false;
  bool _isDonation = false;
  bool isChoosingType = false;

  Future<bool> _tryPost(String text) async {
    try {
      await db.postHubCommunique(text, _chooseType());
      return true;
    } catch (e) {
      return false;
    }
  }

  String _chooseType() {
    if (_isEvent == true) {
      return "evento";
    } else if (_isDonation = true) {
      return "doacoesEtrocas";
    }
    return "normal";
  }

  Future<void> _loadAllPosts() async {
    await db.getAllCommuniques();
  }

  @override
  void initState() {
    super.initState();

    _loadAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 238, 238, 238),
        body: Stack(
          children: [
            ////////////////////CONTÂINER DE FUNDO
            Positioned(
              top: -1,
              bottom: 630,
              child: Container(
                width: context.screenWidth,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 107, 7, 7),
                  shape: BoxShape.rectangle,
                ),
              ),
            ),
            Positioned(
                ///////////////// BOTÃO DE VOLTAR
                left: 30,
                top: 45,
                child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    visualDensity: VisualDensity.compact,
                    icon: const Image(
                        repeat: ImageRepeat.repeat,
                        width: 38,
                        height: 38,
                        semanticLabel: "Sair",
                        color: Color.fromARGB(255, 255, 255, 255),
                        isAntiAlias: true,
                        image:
                            AssetImage("assets/images/icons/fist-icon.png")))),
            Positioned(
                ///////////////// TÍTULO DA PÁGINA
                top: 50,
                left: context.width / 2 - 50,
                right: context.width / 2 - 50,
                child: const Center(
                  child: Text("HUB",
                      style: TextStyle(
                        fontFamily: 'Misfit',
                        letterSpacing: 2,
                        fontStyle: FontStyle.normal,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 243, 243, 243),
                      )),
                )),
            Positioned(
              top: 260,
              child: SizedBox(
                  /////////////////// Contâiner dos posts
                  child: Container(
                alignment: Alignment.topCenter,
                height: context.height * 0.7,
                width: context.width,
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 238, 238, 238),
                ),
                child: Center(
                  child: _buildPostList(listenDb.allCommuniques),
                ),
              )),
            ),
            Positioned(
              bottom: 4.5,
              left: context.width / 2 - 170,
              right: context.width / 2 - 170,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!isChoosingType)
                    Expanded(
                      child: InputBox(
                          sendAction: _tryPost,
                          chooseAction: () {
                            setState(() {
                              isChoosingType = !isChoosingType;
                            });
                          }),
                    )
                  else
                    Expanded(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        fit: StackFit.loose,
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                              child: Container(
                            color: const Color.fromARGB(255, 177, 177, 177),
                            height: context.height * 0.2,
                            width: context.width * 0.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text('Escolha o tipo de publicação'),
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(Icons.star),
                                    SizedBox(width: 1.5),
                                    Icon(Icons.recycling)
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CupertinoSwitch(
                                      value: _isDonation,
                                      activeColor: const Color(
                                          0xFF970202), // Vermelho escuro quando ativado

                                      trackColor: const Color(
                                          0xFFE0E0E0), // Cinza claro quando desativado
                                      thumbColor: Colors.black,
                                      onChanged: (bool value) {
                                        setState(() {
                                          _isDonation = value;
                                          if (value) _isEvent = false;
                                        });
                                      },
                                    ),
                                    CupertinoSwitch(
                                      value: _isEvent,
                                      activeColor: const Color(0xFF970202),
                                      trackColor:
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
                            ),
                          )),
                          Positioned(
                            top: 15,
                            left: 15,
                            child: IconButton(
                                icon: const Icon(Icons.close),
                                color: Colors.black,
                                onPressed: () {
                                  setState(() {
                                    isChoosingType = !isChoosingType;
                                  });
                                }),
                          ),
                        ],
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildPostList(List<Communique> posts) {
    return posts.isEmpty
        ? const CircularProgressIndicator.adaptive()
        : ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return Card(
                  borderOnForeground: true,
                  margin: const EdgeInsetsDirectional.symmetric(
                      vertical: 10.0, horizontal: 10.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      side: BorderSide(
                          width: 0.5,
                          color: post.type == "evento"
                              ? const Color.fromARGB(255, 128, 25, 18)
                              : Colors.black,
                          style: BorderStyle.solid)),
                  child: CommuniqueTile(post: post));
            });
  }
}

import 'package:demopico/features/hub/presentation/widgets/communique_tile.dart';
import 'package:demopico/features/hub/presentation/widgets/input_box.dart';
import 'package:demopico/features/hub/domain/entities/communique.dart';
import 'package:demopico/features/user/data/services/auth_service_v2.dart';
import 'package:demopico/features/user/data/services/database_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HubPage extends StatefulWidget {
  const HubPage({super.key});

  @override
  State<HubPage> createState() => _HubPageState();
}

class _HubPageState extends State<HubPage> {
  final authService = AuthService();

  late final db = Provider.of<DatabaseProvider>(context, listen: false);
  late final listenDb = Provider.of<DatabaseProvider>(context);
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
            Positioned(
                top: 145,
                left: context.width / 2 - 50,
                right: context.width / 2 - 50,
                child: const Center(
                  child: Text("HUB",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 128, 25, 18),
                      )),
                )),
            Positioned(
              top: 200,
              child: SizedBox(
                  /////////////////// Carregar posts
                  child: Container(
                alignment: Alignment.topCenter,
                height: context.height * 0.60,
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
                          Positioned.fill(
                            child: GestureDetector(
                                behavior: HitTestBehavior.deferToChild,
                                dragStartBehavior: DragStartBehavior.start,
                                excludeFromSemantics: true,
                                onTapCancel: null,
                                onDoubleTapCancel: null,
                                onDoubleTap: () {
                                  setState(() {
                                    isChoosingType = false;
                                  });
                                },
                                child: Container(
                                  color: const Color.fromARGB(209, 0, 0, 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Icon(Icons.close,
                                          color: Colors.white),
                                      SizedBox(width: context.width * 0.8),
                                    ],
                                  ),
                                )),
                          ),
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
                                    SizedBox(width: 2),
                                    Icon(Icons.recycling)
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CupertinoSwitch(
                                        value: _isDonation,
                                        activeColor: const Color.fromARGB(
                                            255, 151, 2, 2),
                                        focusColor:
                                            const Color.fromARGB(255, 66, 7, 7),
                                        trackColor: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        thumbColor:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        onChanged: (bool value) {
                                          setState(() {
                                            _isDonation = !_isDonation;
                                            if (_isEvent == true ||
                                                _isDonation == true) {
                                              _isEvent = false;
                                            }
                                          });
                                        }),
                                    CupertinoSwitch(
                                        value: _isEvent,
                                        activeColor: const Color.fromARGB(
                                            255, 151, 2, 2),
                                        focusColor:
                                            const Color.fromARGB(255, 66, 7, 7),
                                        trackColor: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        thumbColor:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        onChanged: (bool value) {
                                          setState(() {
                                            _isEvent = !_isEvent;
                                            if (_isEvent == true ||
                                                _isDonation == true) {
                                              _isDonation = false;
                                            }
                                          });
                                        }),
                                  ],
                                )
                              ],
                            ),
                          ))
                        ],
                      ),
                    )
                ],
              ),
            ),

            //Procede a escolher o tipo de publicação
          ],
        ),
      ),
    );
  }

  /*
  Guardando lógica de submissão
  actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        postController.clear();
                                      },
                                      child: const Text('Cancelar')),
                                  TextButton(
                                      onPressed: () async {
                                        // Postar
                                        _tryPost(postController.text);
                                        Navigator.pop(context);
                                        postController.clear();
                                      },
                                      child: const Text('Postar')),
                                ],
*/

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
                          width: 2.5,
                          color: post.type == "doacoesEtrocas" ||
                                  post.type == "evento"
                              ? Colors.black
                              : const Color.fromARGB(255, 128, 25, 18),
                          style: BorderStyle.solid)),
                  child: CommuniqueTile(post: post));
            });
  }
}

extension on BuildContext {
  get height => MediaQuery.of(this).size.height;
  get width => MediaQuery.of(this).size.width;
}

import 'package:demopico/core/app/routes/app_routes.dart';
import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/core/common/mixins/route_profile_validator.dart';
import 'package:demopico/features/hub/domain/entities/communique.dart';
import 'package:demopico/features/profile/presentation/pages/profile_page_user.dart';
import 'package:demopico/features/user/domain/enums/auth_state.dart';
import 'package:demopico/features/user/presentation/controllers/auth_view_model_account.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage
    show FirebaseStorage;
import 'package:get/get.dart';

class CommuniqueTile extends StatefulWidget {
  final Communique post;
  const CommuniqueTile({super.key, required this.post});

  @override
  State<CommuniqueTile> createState() => _CommuniqueTileState();
}

class _CommuniqueTileState extends State<CommuniqueTile> {
  final storageRef = storage.FirebaseStorage.instance.ref();
  Communique get post => widget.post;
  late Future<Uint8List?> _profileImageFuture;

  @override
  void initState() {
    super.initState();
    _profileImageFuture = _fetchImage();
  }

  Future<Uint8List?> _fetchImage() async {
    debugPrint("Tentando carregar imagem da URL: ${widget.post.pictureUrl}");
    try {
      final httpsReference = storage.FirebaseStorage.instance.refFromURL(post
                      .pictureUrl ==
                  null ||
              post.pictureUrl == ""
          ? "https://firebasestorage.googleapis.com/v0/b/pico-skatepico.appspot.com/o/users%2FfotoPadrao%2FuserPhoto.png?alt=media"
          : post.pictureUrl!);
      final imageData = await httpsReference.getData();
      return imageData;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        debugPrint("Tentou com a URL: ${widget.post.pictureUrl} e deu merda:");
        print(
            "Erro ao Renderizar Imagem do Firebase: ${e.message}, Código: ${e.code}");
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        e.printError();
        e.printInfo();
        print("Erro inesperado ao Renderizar Imagem: ${e.toString()}");
      }
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FutureBuilder<Uint8List?>(
                  future: _profileImageFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting ||
                        snapshot.hasError ||
                        snapshot.data == null ||
                        snapshot.data!.isEmpty) {
                      if (kDebugMode) {
                        print(
                            "ERRO NO SNAPSHOT : ${snapshot.hasError ? snapshot.error : snapshot.data}, ${snapshot.data.isBlank}");
                      }
                      return InkWell(
                        onTap: () {
                          AuthState user =
                              AuthViewModelAccount.instance.authState;
                          RouteProfileValidator.validateRoute(user, post.uid);
                        },
                        child: ClipOval(
                            clipBehavior: Clip.antiAlias,
                            child:
                                post.pictureUrl == "" || post.pictureUrl == null
                                    ? Image.asset('assets/images/userPhoto.png',
                                        width: 40,
                                        height: 40,
                                        alignment: Alignment.centerLeft,
                                        fit: BoxFit.contain)
                                    : Image.network(post.pictureUrl!,
                                        width: 40,
                                        height: 40,
                                        alignment: Alignment.centerLeft,
                                        fit: BoxFit.contain)),
                      );
                    }
                    return InkWell(
                      onTap: () {
                        AuthState user =
                            AuthViewModelAccount.instance.authState;
                        RouteProfileValidator.validateRoute(user, post.uid);
                      },
                      child: ClipOval(
                          clipBehavior: Clip.antiAlias,
                          child:
                              post.pictureUrl == "" || post.pictureUrl == null
                                  ? Image.asset('assets/images/userPhoto.png',
                                      width: 40,
                                      height: 40,
                                      alignment: Alignment.centerLeft,
                                      fit: BoxFit.contain)
                                  : Image.network(post.pictureUrl!,
                                      width: 40,
                                      height: 40,
                                      alignment: Alignment.centerLeft,
                                      fit: BoxFit.contain)),
                    );
                  }),
              const SizedBox(height: 15),
              SizedBox(
                width: 50,
                child: Text(
                  post.vulgo,
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      textDirection: TextDirection.ltr,
                      post.text,
                      maxLines: 10,
                      softWrap: true,
                      textAlign: TextAlign.start,
                      textWidthBasis: TextWidthBasis.longestLine,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.flag_rounded,
                size: 30,
                color: Colors.black,
              ),
              const SizedBox(height: 55),
              if (post.type == TypeCommunique.normal) const SizedBox(),
              if (post.type == TypeCommunique.donation)
                const Icon(
                  Icons.swap_horiz_rounded,
                  color: Color.fromARGB(255, 143, 0, 0),
                ),
              if (post.type == TypeCommunique.event)
                const Icon(
                  Icons.event,
                  color: Color.fromARGB(255, 143, 0, 0),
                ),
            ],
          )
        ],
      ),
    );
  }
}

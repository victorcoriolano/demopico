
import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/features/denunciar/denuncia_model.dart';
import 'package:demopico/features/mapa/presentation/controllers/spot_provider.dart';

import 'package:demopico/features/mapa/presentation/pages/comment_page.dart';
import 'package:demopico/features/mapa/presentation/view_services/modal_helper.dart';
import 'package:demopico/features/mapa/presentation/widgets/spot_info_widgets/atribute_icons.dart';
import 'package:demopico/features/mapa/presentation/widgets/spot_info_widgets/custom_buttons.dart';
import 'package:demopico/features/mapa/presentation/widgets/spot_info_widgets/evaluate_widget.dart';
import 'package:demopico/features/mapa/presentation/widgets/spot_info_widgets/images_top.dart';
import 'package:demopico/features/mapa/presentation/widgets/spot_info_widgets/name_description.dart';
import 'package:demopico/features/mapa/presentation/widgets/spot_info_widgets/obstacle_widget.dart';
import 'package:demopico/features/mapa/presentation/widgets/spot_info_widgets/photo_and_name_widget.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/presentation/controllers/user_database_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';

class ShowPicoWidget extends StatefulWidget {
  final String idPico;

  const ShowPicoWidget({
    super.key,
    required this.idPico,
  });

  @override
  State<ShowPicoWidget> createState() => _ShowPicoWidgetState();
}


class _ShowPicoWidgetState extends State<ShowPicoWidget> {
  UserM? user;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) { 
       context.read<SpotProvider>().initializeWatch(widget.idPico);
    });
  }

  bool isMine(){
    user = context.read<UserDatabaseProvider>().user;
    final pico = context.read<SpotProvider>().pico;

      return user != null && pico != null 
        && pico.userName == user?.name;
    }

  @override
  Widget build(BuildContext context) {
    debugPrint("show pico widget");

    return DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.2,
        maxChildSize: 0.95,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: kAlmostWhite,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  spreadRadius: 2,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Consumer<SpotProvider>(
                builder: (context, spotProvider, child) {
                    if (spotProvider.isLoading){
                      return Center(child: CircularProgressIndicator());
                    }
                    if (spotProvider.pico == null && spotProvider.error != null){
                      return Center(child: Text(spotProvider.error!),);
                    }
                    return Column(
                          children: [
                            // widget da imagem dos spots
                            ImagesTop(images: spotProvider.pico!.imgUrls, isMine: isMine()),
                            Expanded(
                              child: ListView(
                                controller: scrollController,
                                children: [
                                  // Barra de arrastar
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 15),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            ObstacleWidget(obstacles: spotProvider.pico!.obstaculos),
                                            EvaluateWidget(rate: spotProvider.pico!.initialNota, numberReviews: spotProvider.pico!.numeroAvaliacoes),
                                            
                                          ],
                                        ),
                                        const SizedBox(height: 16),
            
                                        // Informações do local e descrição
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // Foto e Nome
                                            PhotoAndNameWidget(
                                              nameUserCreator: spotProvider.pico!.userName ?? "Anônimo", 
                                              //FIXME: PASSANDO A IMAGEM COMO NULL MAIS FUTURAMENTE passar a imagem do user
                                              urlImageUser: null,
                                            ),
                                            const SizedBox(width: 15),
            
                                            // Nome do local e descrição
                                            NameDescription(name: spotProvider.pico!.picoName, description: spotProvider.pico!.description),
                                          ],
                                        ),
                                        const SizedBox(height: 25),
            
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomElevatedButton(  
                                              onPressed: () {
                                                Get.to(() => CommentPage(picoId: widget.idPico));
                                              },
                                              textButton: "ABRIR DISCUSSÃO",
                                            ),
                                            CustomOutlineButton(
                                              onPressed: () =>
                                                  ModalHelper.openRateSpotModal(context, spotProvider.pico!),
                                              textButton: 'AVALIAR PICO',
                                            )
                                          ],
                                        ),
                                        // TODO: implementar o icon de excluir em algum lugar
                                        const SizedBox(height: 9),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          margin: EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(8)),
                                            border: Border.all(
                                              width: 0,
                                              color: const Color.fromARGB(0, 70, 70, 70),
                                            ),
                                            color: kGrey100,                                            
                                          ),
                                          child: Column(
                                            children: [
                                              for (var entry
                                                  in spotProvider.pico!.atributos.entries)
                                                Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        "${entry.key.toUpperCase()}: ",
                                                        style: const TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 18,
                                                          letterSpacing: 2, 
                                                        ),
                                                        textAlign: TextAlign.start,
                                                      ),
                                                      AtributeIcons(value: entry.value,),
                                                    ],
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  //TODO: REFATORAR LÓGICA DE SALVAR SPOT PARA PASSAR 
                                                  //TER UMA LÓGICA PARA SALVAR E UMA PARA FAVORITAR
                                                },
                                                icon: const Icon(Icons.bookmark_border),
                                                tooltip: "Salvar Pico",
                                                iconSize: 35,
                                              ),
                                              IconButton(
                                                  tooltip: "Denunciar Pico",
                                                  onPressed: () {
                                                    if(user == null){
                                                      Get.snackbar("Erro", "Você precisa estar logado para reportar um spot");
                                                      return;
                                                    }
                                                    ModalHelper.openReportSpotModal(context, user?.id, widget.idPico, TypePublication.pico);
                                                  },
                                                  icon: const Icon(Icons.flag),
                                                  iconSize: 35),
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(Icons.share_rounded),
                                                  iconSize: 35),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                },
            )
          );
        });
  }
}

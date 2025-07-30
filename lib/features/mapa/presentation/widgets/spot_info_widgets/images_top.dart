import 'package:flutter/material.dart';

class ImagesTop extends StatefulWidget {
  final List<String> images;
  const ImagesTop({ super.key , required this.images });

  @override
  State<ImagesTop> createState() => _ImagesTopState();
}

class _ImagesTopState extends State<ImagesTop> {
    int currentIndex = 0;
   @override
   Widget build(BuildContext context) {
    // TODO: REFATORAR ESSA WIDGET
       return Stack(
                  children: [

                              PageView.builder(
                                itemCount: widget.images.length,
                                onPageChanged: (int page) {
                                  setState(() {
                                    currentIndex = page;
                                  });
                                },
                                itemBuilder: (context, pagePosition) {
                                  
                                      
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          IconButton(
                                            icon: const Icon(
                                              Icons.close,
                                              color: Color.fromARGB(
                                                  255, 243, 243, 243),
                                            ),
                                            padding: const EdgeInsets.all(10),
                                            iconSize: 36,
                                            onPressed: () {
                                              Navigator.pop(
                                                  context); // Retorna para a tela anterior
                                            },
                                          ),
                                          Visibility(
                                            visible: isMine(),
                                            child: IconButton(
                                              onPressed: () {
                                                ModalHelper.openModalDeleteSpot(context, widget.pico);
                                              } ,
                                              icon: const Icon(
                                                Icons.delete,
                                                color: kBlack,
                                              ),
                                              padding:
                                                  const EdgeInsets.all(10),
                                            ),
                                          ),
                                        ],
                                      
                                  );
                                      return null;
                                },
                              ),
                              //images
                              Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(30)),
                                        ),
                                        clipBehavior: Clip.hardEdge,
                                        child: Image.network(
                                          widget.images[pagePosition],
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                      ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        height: 5,
                        width: 80,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 240, 238, 238),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
  }
}
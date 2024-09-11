import 'package:demopico/infra/ui/widgets/hub_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HubPage extends StatefulWidget {
  const HubPage({super.key});

  @override
  State<HubPage> createState() => _HubPageState();
}

class _HubPageState extends State<HubPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
          width: MediaQuery.maybeSizeOf(context)?.width ?? double.infinity,
          height: MediaQuery.maybeSizeOf(context)?.height ?? double.infinity,
          decoration: const BoxDecoration(
              backgroundBlendMode: BlendMode.darken, color: Color(0xFFEEEEEE)),
          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                  height: 100,
                  child: Container(
                    color: const Color.fromARGB(255, 139, 0, 0),
                  )),
              SizedBox(
                  height: MediaQuery.of(context).viewInsets.top + 80,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            Get.close(1);
                          },
                          child: const Icon(Icons.arrow_left,
                              size: 46, color: Color.fromARGB(255, 0, 0, 0))),
                      const Text(
                        'HUB',
                        style: TextStyle(
                            color: Color.fromARGB(255, 139, 0, 0),
                            fontSize: 24,
                            shadows: [
                              Shadow(color: Colors.black, blurRadius: 1)
                            ],
                            fontWeight: FontWeight.bold),
                        strutStyle: StrutStyle(fontSize: 30),
                      ),
                      const SizedBox(width: 50),
                    ],
                  )),
              SizedBox(
                  height: 700,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: HubTile(
                              userName: 'Arthur Selingin',
                              text:
                                  'Quem cola pista de Itapevi?Quem cola pista de Itapevi?Quem cola pista de Itapevi?Quem cola pista de Itapevi?Quem cola pista de Itapevi?Quem cola pista de Itapevi?',
                            ));
                      },
                    ),
                  ))
            ]),
          )),
    ));
  }
}

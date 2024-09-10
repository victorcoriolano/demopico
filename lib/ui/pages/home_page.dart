import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState(
    

  );
}

class _HomePageState extends State<HomePage> {

  void met(){
    return;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  heightFactor: 2.3,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 171, 96, 96),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: 80,
                          height: 60,
                          child: const Row(
                            children: [
                              Icon(
                                Icons.cloudy_snowing,
                                color: Color.fromARGB(255, 0, 0, 0),
                                size: 40,
                              ),
                              SizedBox(width: 2),
                              Text(
                                style: TextStyle(
                                  fontSize: 15
                                ),
                                '19°',
                              )
                            ]
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(left: 80, right: 140)),
                      const SizedBox(
                        width: 80,
                        height: 80,
                        child: Icon(
                          Icons.account_circle,
                          color: Color.fromARGB(255, 0, 0, 0),
                          size: 50,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const Align(
              heightFactor: 2.3,
              child: Positioned(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          color: Color.fromARGB(255, 0, 0, 0),
                          size: 50,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left:12, right: 13),
                          child: Image(
                            width: 250,
                            height: 250,
                            image: AssetImage('images/logo_s_trans.png'),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Color.fromARGB(255, 0, 0, 0),
                          size: 50,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
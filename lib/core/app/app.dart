
import 'dart:ui';
import 'dart:math' as math;
import 'package:demopico/core/app/home_page.dart';
import 'package:demopico/core/app/providers/providers.dart';
import 'package:demopico/core/app/routes/app_pages.dart';
import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/core/common/ui_context_extension.dart';
import 'package:demopico/features/home/presentation/widgets/central_page_background.dart';
import 'package:demopico/features/home/presentation/widgets/events_bottom_sheet.dart';
import 'package:demopico/features/home/presentation/widgets/skatepico_logo.dart';
import 'package:demopico/features/mapa/presentation/controllers/map_controller.dart' show MapControllerProvider;
import 'package:demopico/features/mapa/presentation/view_services/modal_helper.dart' show ModalHelper;
import 'package:demopico/features/mapa/presentation/widgets/search_bar.dart';
import 'package:demopico/features/profile/presentation/bidings/auth_biding.dart';
import 'package:demopico/features/profile/presentation/pages/profile_page_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class MyAppWidget extends StatelessWidget {
  const MyAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: myProviders,
      child: GetMaterialApp(
        home: HomePageTest(),
        debugShowCheckedModeBanner: false,
        title: 'SKATEPICO',
        theme: appTheme,
        checkerboardRasterCacheImages: true,
        getPages: AppPages.routes,
        initialBinding: AuthBinding(),

      ),
    );
  }
}

class HomePageTest extends StatefulWidget {
  const HomePageTest({super.key});

  @override
  State<HomePageTest> createState() => _HomePageTestState();
}

class _HomePageTestState extends State<HomePageTest> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  bool isItHome = true;
  double opacity = 1;
   Widget dragBack = GestureDetector(
    key: ValueKey('sheet'),
          onVerticalDragUpdate: (details) {
            _controller.value -= details.primaryDelta! / 150;
          },
          onVerticalDragEnd: (details) {
            if (opacity == 0){
              setState(() {
               isItHome = false;
              });
            }
            if(mounted && _controller.isAnimating || _controller.status == AnimationStatus.completed){
              _controller.value == 0 ? opacity = 1 : opacity = 0;
              setState(() {
                isItHome = false;
              });
              return;
            }
            final double flingVelocity = details.velocity.pixelsPerSecond.dy / 150;
            if(flingVelocity < 0.0) {
              _controller.fling(velocity: math.max(2, -flingVelocity));
            } else if (flingVelocity > 0) {
              _controller.fling(velocity: math.min(-2, -flingVelocity));
            } else {
              _controller.fling(velocity: _controller.value < 0.5 ? -2 : 2);
            }
          },
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: opacity,
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(11, 62, 73, 79),
                borderRadius: BorderRadius.vertical(top: Radius.circular(16), bottom: Radius.circular(0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: BorderSide.strokeAlignInside,
                    blurStyle: BlurStyle.solid,
                    blurRadius: 1,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              height: 110,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Material(
                  child: Text(
                    "acessar o menu",
                    style: TextStyle(
                      fontSize: 25,
                      shadows: [
                        Shadow(
                          color: Colors.black38,
                          offset: Offset(1, 3),
                          blurRadius: 2,
                        ),
                      ],
                      fontFamily: 'Urban',
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(112, 55, 71, 79),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );

    return Stack(
      children: [
        SearchHomePage(),
        Positioned(
          bottom: 0,
          child: dragBack
        ),
        
     ],
    );
  }
}









































class SearchHomePage extends StatefulWidget {
  const SearchHomePage({
    super.key,
  });

  @override
  State<SearchHomePage> createState() => _SearchHomePageState();
}

class _SearchHomePageState extends State<SearchHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SkatePicoLogo(),
          ),
          SizedBox(height: context.screenHeight * 0.2),
          Flexible(
            fit: FlexFit.loose,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25),
              child: SearchBarSpots(
                onTapSuggestion: (pico) {
                  context
                      .read<MapControllerProvider>()
                      .reajustarCameraPosition(LatLng(pico.location.latitude, pico.location.longitude));
                  ModalHelper.openModalInfoPico(
                      context, pico);
                      }),
            ),
          ),
        Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}





































class DraggableBackground extends StatefulWidget {
  const DraggableBackground({
    required this.controller,
    super.key,
  });
  final AnimationController controller;

  @override
  State<DraggableBackground> createState() => _DraggableBackgroundState();
}

class _DraggableBackgroundState extends State<DraggableBackground> {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    double opacity = 1;
    return Placeholder();
    }
}

bool isAtHome = true;

void triggerAnimation(double opacity) {
  opacity == 0 ? isAtHome = false : isAtHome = true;
}



































class AnimationSwitch extends StatefulWidget {
  const AnimationSwitch({super.key});

  @override
  State<AnimationSwitch> createState() => _AnimationSwitchState();
}

class _AnimationSwitchState extends State<AnimationSwitch> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(duration: Duration(seconds:2), vsync: this);
    
  Widget buildDraggableBackground() {
    return switch (_controller.status) {
      AnimationStatus.completed => Container(
        width: 100,
        height: 100,
        color: Colors.amber,
      ),
      AnimationStatus.dismissed => DraggableBackground(controller: _controller),
      AnimationStatus.forward => DraggableBackground(controller: _controller),
      AnimationStatus.reverse => DraggableBackground(controller: _controller),
    };
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() { 
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    Widget focusedWidget = DraggableBackground(controller: _controller);

    return AnimatedSwitcher(
      transitionBuilder: (child, animation) {
        return SlideTransition(position: Tween<Offset>(
        begin: Offset.zero,
        end: const Offset(0.0, 1.5), 
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.elasticIn,
        )));
      },
      duration: Duration(seconds: 3),
      child: DraggableBackground(controller: _controller),
    );
  }
}
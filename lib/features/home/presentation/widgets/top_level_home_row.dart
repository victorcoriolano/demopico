import 'package:cached_network_image/cached_network_image.dart';
import 'package:demopico/core/app/routes/app_routes.dart';

import 'package:demopico/features/home/infra/dialog_page_route.dart';
import 'package:demopico/features/home/presentation/widgets/weather_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopLevelHomeRow extends StatefulWidget {
  const TopLevelHomeRow({
    super.key,
    required String? userImage,
    required Map<String, dynamic>? initialWeatherInfo,
  })  : _userImage = userImage,
        _initialWeatherInfo = initialWeatherInfo;

  final Map<String, dynamic>? _initialWeatherInfo;
  final String? _userImage;

  @override
  State<TopLevelHomeRow> createState() => _TopLevelHomeRowState();
}

// TODO: IMPLEMENT HERO TO THE CLIMATE ICON

class _TopLevelHomeRowState extends State<TopLevelHomeRow> {
  @override
  Widget build(BuildContext context) {
    
    final bool isDay = widget._initialWeatherInfo?['isDay'] as bool? ?? true;
    final double temperature =
        (widget._initialWeatherInfo?['temperature'] as num?)?.toDouble() ?? 0.0;
    return Positioned(
      top: 110,
      right: 10,
      left: 10,
      //Caixa que contém a row
      child: SizedBox(
      
        width: MediaQuery.maybeSizeOf(context)!.width,
        height: 120,
        //Row
        child: Row(children: [
          //BOTÃO DE CLIMA
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            verticalDirection: VerticalDirection.down,
            children: [
              ElevatedButton(
                  onPressed: () => Navigator.push(context,
                          WeatherDialogRoute(builder: (context) {
                        return WeatherDialog();
                      })),
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.fromLTRB(15, 15, 15, 15)),
                    backgroundColor: WidgetStateProperty.all<Color>(
                        Color.fromARGB(255, 255, 255, 255)),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color.fromARGB(255, 0, 0, 0),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(90.0),
                    )),
                    elevation: WidgetStateProperty.all<double>(1),
                    shadowColor: WidgetStateProperty.all<Color>(
                        Color.fromARGB(255, 0, 0, 0)),
                  ),
                  child: Row(
                    children: [
                      Icon(isDay ? Icons.wb_sunny : Icons.nightlight_round,
                          size: 38, color: Colors.black87),
                      SizedBox(width: 10),
                      Text('$temperature°C',
                          style: TextStyle(fontSize: 20, color: Colors.black87))
                    ],
                  )),
            ],
          ),
          Spacer(),
          GestureDetector(
              onTap: () => Get.toNamed(
                    Paths.profile,),
              child: widget._userImage == null
                  ? Icon(Icons.supervised_user_circle, size: 64, color: Colors.black,)
                  : CircleAvatar(
                      radius: 32,
                      backgroundImage: CachedNetworkImageProvider(widget._userImage!),
                      backgroundColor: Colors.transparent)),
        ]),
      ),
    );
  }
}

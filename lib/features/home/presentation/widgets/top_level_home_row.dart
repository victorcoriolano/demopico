import 'package:demopico/core/app/auth_wrapper.dart';
import 'package:demopico/core/common/ui_context_extension.dart';
import 'package:demopico/features/home/domain/model/forecast_weather_model.dart';
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
    if (widget._initialWeatherInfo == null) {
      return const SizedBox.shrink();
    }
    final bool isDay = widget._initialWeatherInfo?['isDay'] as bool? ?? true;
    final double temperature =
        (widget._initialWeatherInfo?['temperature'] as num?)?.toDouble() ?? 0.0;
    return Positioned(
      top: 70,
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
              onTap: () => Get.to(
                    AuthWrapper(),
                    transition: Transition.rightToLeftWithFade,
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.fastEaseInToSlowEaseOut,
                  ),
              child: widget._userImage == null
                  ? Icon(Icons.supervised_user_circle, size: 64)
                  : CircleAvatar(
                      radius: 32,
                      backgroundImage: NetworkImage(widget._userImage!),
                      backgroundColor: Colors.transparent)),
        ]),
      ),
    );
  }
}

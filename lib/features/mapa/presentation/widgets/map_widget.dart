import 'package:demopico/core/common/inject_dependencies.dart';
import 'package:demopico/features/mapa/data/services/maps_service_singleton.dart';
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/presentation/controllers/spot_controller.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart'; // Importa o permission_handler

class MapWidget extends StatefulWidget {

  const MapWidget({super.key,});

  @override
  MapWidgetState createState() => MapWidgetState();
}

class MapWidgetState extends State<MapWidget> {

  final _controller = serviceLocator<SpotController>();

  @override
  void initState() {
    super.initState();
    loadPico();//carregar os marker do bd quando o widget iniciar
  }

  Future<void> loadPico() async {
    await _controller.showAllPico(context);
    setState(() {
      marcadores.addAll(_controller.markers);
    });
  }
  Set<Marker> marcadores = <Marker>{};
  String _locationMessage = "Aguardando localização...";
  late GoogleMapController mapController;
  LatLng _center = LatLng(-23.548546, -46.9400143);
  // Inicializa o centro do mapa

  // Função para verificar permissões
  Future<bool> _handleLocationPermission() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      // Solicita permissão
      status = await Permission.location.request();
      if (!status.isGranted) {
        // Se o usuário negar a permissão, exibe uma mensagem
        setState(() {
          _locationMessage = "Permissão de localização negada.";
        });
        return false;
      }
    }
    return true;
  }

  // Função para obter a localização
  Future<void> _getLocation() async {
    bool permissionGranted = await _handleLocationPermission();
    if (!permissionGranted) return;

    Position position;
    try {
      // Configurações específicas para Android, iOS e Web
      LocationSettings locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high, // Precisão alta
        distanceFilter: 50, // Atualiza a cada 100 metros
      );

      // Obtém a localização atual com as configurações definidas
      position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );

      // Atualiza a posição do mapa após obter a localização
      setState(() {
        _locationMessage =
            "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
        _center = LatLng(position.latitude, position.longitude); // Atualiza o centro com a nova localização
        mapController.animateCamera(CameraUpdate.newLatLng(_center)); // Move o mapa para a nova localização
      });
    } catch (e) {
      setState(() {
        _locationMessage = "Erro ao obter localização: $e";
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return  GoogleMap ( 
      onMapCreated: (GoogleMapController controller) {
          MapsServiceSingleton().setController(controller);
      },
      zoomControlsEnabled: false, 
      initialCameraPosition:CameraPosition(
        target: _center,
        zoom: 15.0,
      ),
      scrollGesturesEnabled: true,
      rotateGesturesEnabled: true,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      tiltGesturesEnabled: true,
      markers: marcadores,
      //onLongPress: (argument) => simulaCriarPico(argument), simulação de criar pico em passando a latlang
    );
  }
  
/*   simulaCriarPico(LatLng argument) {
    final Pico pico = Pico(
      nota: 0, 
      numeroAvaliacoes: 0, 
      long: argument.longitude, 
      lat: argument.latitude, 
      description: "testando criar a partir de uma latlang do mapa", 
      atributos: {}, 
      fotoPico: null, 
      obstaculos: [], 
      utilidades: [], 
      userCreator: 'userCreator', 
      urlIdPico: '', 
      picoName: 'picoName2');
    _controller.createSpot(pico, context
    );
  } */
  


}


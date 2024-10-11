import 'package:demopico/features/mapa/data/services/maps_service_singleton.dart';
import 'package:demopico/features/mapa/presentation/controllers/add_pico_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/spot_controller.dart';
import 'package:demopico/features/mapa/presentation/widgets/add_pico_modal/container_telas.dart';
import 'package:demopico/features/mapa/presentation/widgets/add_pico_widget.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart'; // Importa o permission_handler

class MapWidget extends StatefulWidget {

  const MapWidget({super.key,});

  @override
  MapWidgetState createState() => MapWidgetState();
}

class MapWidgetState extends State<MapWidget> {
  Set<Marker> markers = {};
  /* @override
  void initState() {
    super.initState();
    loadPico();
  } */

  Future<void> loadPico() async {
    markers = await context.read<SpotControllerProvider>().turnsPicoToMarker(context);
  }

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
    if (permissionGranted) {
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
        print("pegando location");
      });
    } catch (e) {
      setState(() {
        _locationMessage = "Erro ao obter localização: $e";
      });
    }}
  }
  @override
  Widget build(BuildContext context) {
    // consome os dados do provider para manter a tela atualizada
    return  Consumer<AddPicoControllerProvider>(
      builder: (context, provider, child) =>
      GoogleMap ( 
        onMapCreated: (GoogleMapController controller) async {
          mapController = controller;
          await loadPico();
          await _getLocation();
          provider.atualizarLocalizacao(_center);
          print(_center);
          print(_locationMessage);
        },
        zoomControlsEnabled: false, 
        initialCameraPosition:CameraPosition(
          target: _center ,
          zoom: 15.0,
        ),
        scrollGesturesEnabled: true,
        rotateGesturesEnabled: true,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        tiltGesturesEnabled: true,
        markers: markers,
        onLongPress: (argument) => Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => ContainerTelas(
              lat: argument.latitude,
              long: argument.longitude,
            ),
          ),
        ), 
      ),
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


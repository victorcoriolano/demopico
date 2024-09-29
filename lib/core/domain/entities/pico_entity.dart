import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Picos {
  final String urlIdPico;
  final String picoName;
  final String? description;
  final LatLng position;
  final String userName;
  final String fotoPico;
  final Map? comentarios; 
  final  double notaPico;
  final Map atributos;  


  Picos( this.description, this.comentarios, this.notaPico,{required this.atributos, required this.position, required this.userName, required this.fotoPico, required this.urlIdPico, 
  required this.picoName,  
});
}
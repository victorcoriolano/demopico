
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Pico {
  final int idPico;
  final String spotName;
  final String? description;
  final LatLng position;
  final String userName;
  final String fotoPico;
  final Map comentarios; 
  final Array elementosPicos;
  final  double notaPico;
  final Map atributos;  
  final ArrayConfig denunciasPico;

  Pico( this.description, this.comentarios, this.elementosPicos, this.notaPico, this.atributos, this.denunciasPico, { required this.position, required this.userName, required this.fotoPico, required this.id, 
  required this.spotName,  
});
}
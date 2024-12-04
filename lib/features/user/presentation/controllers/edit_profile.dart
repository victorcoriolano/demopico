import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileProvider extends ChangeNotifier {
  static FirebaseAuth auth = FirebaseAuth.instance;
  final pegadorImage = ImagePicker();
  final List<File?> image = [];
  final String uid = auth.currentUser!.uid;
  var imgUser = '';
  var beforeImages = [];

Future<void> selecionarImag() async {
  imgUser = ''; // Reseta a variável
  image.clear();

  try {
    final img = await pegadorImage.pickImage(source: ImageSource.gallery);
    if (img != null) {
      image.add(File(img.path));
    }

    // Aguarda o upload das imagens e a atualização de imgUser
    await testeSubindoImg(image);
   
    // Verifica se imgUser foi atualizado
    if (imgUser != null && imgUser.isNotEmpty) {
      print("Imagem enviada com sucesso! URL: $imgUser");
    } else {
      print("Falha ao obter URL da imagem");
    }
  } on Exception catch (e) {
    print("Erro ao selecionar ou enviar imagem: $e");
  }
}


 Future<String?> testeSubindoImg(List<File?> imgs) async {
  try {
    for (var img in imgs) {
      // Gera um nome único para cada imagem
      final uniqueName = DateTime.now().millisecondsSinceEpoch.toString();

      final ref = FirebaseStorage.instance
          .ref()
          .child('users')
          .child('{$uid}')
          .child("'$uniqueName.jpg'");

      print('Enviando imagem: ${img!.path}');

      // Faz o upload da imagem
      await ref.putFile(img);
;
      // Adiciona a URL de download à lista
      final downloadURL = await ref.getDownloadURL();
    
      imgUser = downloadURL;
      beforeImages.add(imgUser);
      
      print('URL gerada: $downloadURL');
   
    }
  
  } on Exception catch (e) {
    print("Erro ao subir imagem pro storage: $e");
  }
  print("${imgUser} aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
  return imgUser;
}

}
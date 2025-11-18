import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';

abstract interface class IColetivoDatasource {
  Future<FirebaseDTO> getCollectivoDoc(String id);
  Future<List<FirebaseDTO>> getCollectiveForProfile(String idProfile);
  Future<List<FirebaseDTO>> getAllCollectives();
    Future<FirebaseDTO> createColetivo(FirebaseDTO coletivo);
    Future<void> updateColetivo(FirebaseDTO coletivo);
    Future<void> updateListOnCollective({required String nameField, required String idCollective, required List<dynamic> newListData});
 Future<void> deleteCollective(String id);
}
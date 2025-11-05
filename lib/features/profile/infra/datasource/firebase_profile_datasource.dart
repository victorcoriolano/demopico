
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/core/common/collections/collections.dart';
import 'package:demopico/features/external/datasources/firebase/crud_firebase.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/features/profile/domain/interfaces/i_profile_data_source.dart';
import 'package:flutter/widgets.dart';

class FirebaseProfileDatasource implements IProfileDataSource<FirebaseDTO>{
  static FirebaseProfileDatasource? _instance;
  static FirebaseProfileDatasource get getInstance {
    return _instance ??= FirebaseProfileDatasource(
      crud: CrudFirebase(collection: Collections.profiles, firestore: FirebaseFirestore.instance) 
    );
  }


  final CrudFirebase _crudFirebase;
  
  
  FirebaseProfileDatasource({required CrudFirebase crud}): _crudFirebase = crud;

  @override
  Future<FirebaseDTO> createProfile(FirebaseDTO profile) async  {
    debugPrint("Data source - criando profile: $profile");
    return await _crudFirebase.setData(profile.id, profile);
  }

  @override
  Future<void> deleteProfile(String idUser) async  {
    return await _crudFirebase.delete(idUser);
  }

  @override
  Future<FirebaseDTO> getProfileByUser(String id) async  {
    final profile = await _crudFirebase.read(id);
    debugPrint(profile.toString());
    return profile;
  }

  @override
  Future<FirebaseDTO> updateProfile(FirebaseDTO profile) async  {
    return await _crudFirebase.update(profile);
  }
  
  @override
  Future<void> updatedSingleField({required String id, required String field, required value})  async{
    return await _crudFirebase.updateField(id, field, value);
  }
  
}
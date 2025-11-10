abstract class IProfileDataSource<DTO> {
  Future<DTO> createProfile(DTO profile);

  Future<void> updatedSingleField({required String id,  required String field, required dynamic value });

  
  Future<void> deleteProfile(String idUser);
  
  Future<DTO> getProfileByUser(String id);
  
 Future<DTO> updateProfile(DTO profile);
}
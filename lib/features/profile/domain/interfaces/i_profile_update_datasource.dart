abstract class IProfileUpdateDatasource{
  Future<void> updateContributions(String uid);
  Future<void> updateFollowers(String uid);
  Future<void> updateBio(String newBio, String uid);
  Future<void> updatePhoto(String newPhoto, String uid);
 
}

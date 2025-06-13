abstract class IProfileUpdateDatasource{
  void updateContributions(String uid);
  void updateFollowers(String uid);
  void updateBio(String newBio, String uid);
  void updatePhoto(String newPhoto, String uid);
 
}

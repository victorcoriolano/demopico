
import 'package:cloud_firestore/cloud_firestore.dart';


class GetIdByVulgo {
  
  
  final FirebaseFirestore firestore;

  GetIdByVulgo(this.firestore,);

  

  Future<String?> getIDByVulgo(String vulgo,) async{
    QuerySnapshot idSnapshot = await firestore.collection("users_email_vulgo").where('vulgo', isEqualTo:  vulgo).get();
    if(idSnapshot.docs.isNotEmpty){
      return idSnapshot.docs.first.id;
    }else{
      return null;
    }
  }

  Future<String?> getEmailByID(String id) async{
    DocumentSnapshot emailSnapshot = await firestore.collection("user_email_vulgo").doc(id).get();
    if(emailSnapshot.exists){
      Map<String, dynamic>? data = emailSnapshot.data() as Map<String, dynamic>?;
      if (data != null && data.containsKey('email')) {
        return data['email'] as String;
      }else{
        return null;
      }
    }else{
      return null;
    }
  }
}
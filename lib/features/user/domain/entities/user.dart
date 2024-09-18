
class User{
  final String? id;
  final String? vulgo;
  final String email;
  final String? senha;
  final bool isColetivo;
  
  

  User({
    required this.id,
    required this.vulgo, 
    required this.email, 
    required this.senha, 
    this.isColetivo = false,
    });

  bool isValidEmail() {
    return email.contains('@');
  }

  bool isValidSenha(){
    return senha!.length >= 8; // regra de negocia 
  }

  bool isValidVulgo(){
    return vulgo!.length <= 15;// regra de negocia
  }
}
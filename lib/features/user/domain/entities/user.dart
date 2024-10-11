
class User{
  final String? id;
  final String? vulgo;
  final String? email;
  final String? senha;
  final bool isColetivo;
  
  

  User({
    this.id,
    this.vulgo, 
    this.email, 
    this.senha, 
    this.isColetivo = false,
    });
/*
mover essa lógica pro form validator
  bool isValidEmail() {
    return email!.contains('@');
  }

  bool isValidSenha(){
    return senha!.length >= 8; // regra de negocia 
  }

  bool isValidVulgo(){
    return vulgo!.length <= 15;// regra de negocia
  }
  */
}
mixin Validators {
  String? isNotEmpty(String? value){
    if(value!.isEmpty) return "Campo obrigatório";
    return null;
  }

  String? isValidEmail(String? value){
    if(!(value!.contains('@'))) return "Insira um email valido";
    return null;
  }

  String? isValidPassword(String? value){
    if(value!.length < 6) return "A senha deve ter no mínimo 6 caracteres";
    return null;
  }

  String? combineValidators(List<String? Function()> validators){
    for(final val in validators){
      final validar = val();
      if( validar != null) return validar;
    }
    return null;
  }

  String? checkPassword(String? senha1, String? senha2){
    if(senha1 == senha2) return null;
    return "As senhas devem ser iguais";
  }
}
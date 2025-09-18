
import 'package:demopico/core/common/errors/domain_failures.dart';

class VulgoVo {
  final String value;
  
  VulgoVo._({required this.value});

  factory VulgoVo(String vulgo){
    if(vulgo.length > 3){
      return VulgoVo._(value: vulgo);
    }
    throw InvalidVulgoFailure();
  }

  factory VulgoVo.empty(){
    return VulgoVo("");
  }
}
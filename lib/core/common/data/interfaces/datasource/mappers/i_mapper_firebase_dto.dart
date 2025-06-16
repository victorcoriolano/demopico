import 'package:demopico/core/common/data/interfaces/datasource/i_mapper_dto.dart';
import 'package:demopico/features/mapa/data/dtos/firebase_dto.dart';

 abstract class IMapperFirebaseDto<Y> implements IMapperDto<FirebaseDTO, Y> {
  
  @override
  Y fromDto(FirebaseDTO dto);
 
  @override
  FirebaseDTO toDTO(Y model);

} 
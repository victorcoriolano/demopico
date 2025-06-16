//strategy 
abstract class IMapperDto<T, Y>{
   T toDTO (Y model);
   Y fromDto (T dto);
}
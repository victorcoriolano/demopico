//strategy 
abstract class IMapperDto<T, Y>{
   T toDatasourceDto (Y model);
   Y toModalDto (T dto);
}
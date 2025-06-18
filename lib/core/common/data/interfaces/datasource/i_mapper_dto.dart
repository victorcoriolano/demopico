//strategy 
abstract class IMapperDto<Model, DTO>{
   DTO toDTO (Model model);
   Model toModel (DTO dto);
}
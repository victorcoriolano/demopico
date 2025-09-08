
abstract class ICommentSpotDataSource<DTO> {
  Future<DTO> create(DTO newComment);
  Future<void> delete(String id);
  Future<List<DTO>> getBySpotId(String spotId);
  Future<void> update(DTO commentDto);
}

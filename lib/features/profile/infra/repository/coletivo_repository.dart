import 'package:demopico/core/common/auth/domain/entities/coletivo_entity.dart';
import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto_mapper.dart';
import 'package:demopico/features/profile/domain/interfaces/i_coletivo_datasource.dart';
import 'package:demopico/features/profile/domain/interfaces/i_coletivo_repository.dart';
import 'package:demopico/features/profile/domain/interfaces/i_post_datasource.dart';
import 'package:demopico/features/profile/domain/models/post.dart';
import 'package:demopico/features/profile/infra/datasource/firebase_collective_datasource.dart';
import 'package:demopico/features/profile/infra/datasource/firebase_post_datasource.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_datasource_service.dart';
import 'package:demopico/features/user/domain/models/user_model.dart';
import 'package:demopico/features/user/infra/datasource/remote/user_firebase_datasource.dart';


class ColetivoRepository implements IColetivoRepository{
  final IColetivoDatasource _datasource;
  final IPostDatasource _postDatasource;
  final IUserDataSource<FirebaseDTO> _userDataSource;

  ColetivoRepository({required IColetivoDatasource datasource, required IPostDatasource postDatasource, required IUserDataSource<FirebaseDTO> userDatasource}): _datasource = datasource, _postDatasource = postDatasource, _userDataSource = userDatasource;

  static ColetivoRepository? _instance;
  static ColetivoRepository get instance => _instance ?? ColetivoRepository(
    datasource: FirebaseCollectiveDatasource.instance,
    postDatasource: FirebasePostDatasource.getInstance,
    userDatasource: UserFirebaseDataSource.getInstance, );  



  @override
  Future<void> addUserOnCollective(UserIdentification user) {
    return _datasource.addUserOnCollective(userIdentificationMapper.toDTO(user));
  }

  @override
  Future<ColetivoEntity> createColetivo(ColetivoEntity coletivo) async {
    final collectiveDTO = await _datasource.createColetivo(coletivoDtoMapper.toDTO(coletivo));
    return coletivoDtoMapper.toModel(collectiveDTO);
  }

  @override
  Future<void> removeUser(UserIdentification user) {
    // TODO: implement removeUser
    throw UnimplementedError();
  }

  @override
  Future<void> sendInviteUsers(List<UserIdentification> user) {
    // TODO: implement sendInviteUsers
    throw UnimplementedError();
  }

  @override
  Future<void> updateColetivo(ColetivoEntity coletivo) {
    // TODO: implement updateColetivo
    throw UnimplementedError();
  }
  
  @override
  Future<ColetivoEntity> getColetivoByID(String idColetivo) async {
    final coletivoDto = await _datasource.getCollectivoDoc(idColetivo);
    
    final partialColetivo = coletivoDtoMapper.toModel(coletivoDto);

    final futures = await Future.wait([
      _fetchUser(partialColetivo.modarator.id),
      
      _fetchMembers(partialColetivo.members.map((m) => m.id).toList()),
      
      _fetchPublications(idColetivo),
    ]);

    final UserIdentification modarator = futures[0] as UserIdentification;
    final List<UserIdentification> members = futures[1] as List<UserIdentification>;
    final List<Post> publications = futures[2] as List<Post>;

    return partialColetivo.copyWith(
      modarator: modarator,
      members: members,
      publications: publications,
    );
  }

  Future<UserIdentification> _fetchUser(String id) async {
    final user = mapperUserModel.toModel(await _userDataSource.getUserDetails(id));
    return UserIdentification(
      id: id, name: user.name, profilePictureUrl: user.avatar);
  }

  Future<List<UserIdentification>> _fetchMembers(List<String> ids) async {
    final users = (await _userDataSource.getUsersByIds(ids)).map((u) => mapperUserModel.toModel(u)).toList();
    return users.map((user) {
      return UserIdentification(
      id: user.id, name: user.name, profilePictureUrl: user.avatar);
    }).toList();
  }

  Future<List<Post>> _fetchPublications(String id) async{
    return (await _postDatasource.getPostsByUserId(id)).map((dto) => postMapper.fromJson(dto.data, dto.id)).toList();
  } 
  
}
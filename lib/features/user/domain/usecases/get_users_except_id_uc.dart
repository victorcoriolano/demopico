
import 'package:demopico/features/user/domain/interfaces/i_users_repository.dart';
import 'package:demopico/features/user/domain/models/user_model.dart';
import 'package:demopico/features/user/infra/repositories/users_repository.dart';

class GetUsersExceptIdUc {
  final IUsersRepository _iUsersRepository;

  GetUsersExceptIdUc() : _iUsersRepository = UsersRepository.getInstance;

  Future<List<UserM>> execute(String idUser){
    return _iUsersRepository.getSuggestionsProfileExcept(idUser);
  }
}
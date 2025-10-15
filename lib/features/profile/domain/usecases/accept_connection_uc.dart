
import 'package:demopico/features/profile/domain/interfaces/i_message_repository.dart';
import 'package:demopico/features/profile/domain/interfaces/i_network_repository.dart';
import 'package:demopico/features/profile/domain/interfaces/i_profile_repository.dart';
import 'package:demopico/features/profile/domain/models/relationship.dart';
import 'package:demopico/features/profile/infra/repository/chat_repository.dart';
import 'package:demopico/features/profile/infra/repository/network_repository.dart';
import 'package:demopico/features/profile/infra/repository/profile_repository.dart';

class AcceptConnectionUc {
  static AcceptConnectionUc? _instance;
  static AcceptConnectionUc get instance {
    _instance ??= AcceptConnectionUc(
      networkRepository: NetworkRepository.instance,
      profileRepository: ProfileRepositoryImpl.getInstance,
      messageRepository: ChatRepository.instance,
    );
    return _instance!;
  }

  final INetworkRepository _networkRepository;
  final IProfileRepository _profileRepository;
  final ImessageRepository _chatRepository;

  AcceptConnectionUc({
    required ImessageRepository messageRepository,
    required INetworkRepository networkRepository,
    required IProfileRepository profileRepository})
      : _networkRepository = networkRepository,
        _chatRepository = messageRepository,
        _profileRepository =profileRepository ;

  Future<Relationship> execute(Relationship connection, ) async {
    final relationship = await _networkRepository.updateRelationship(connection);
    // atualizando os dois perfis 
    var profileRequesterUser = await _profileRepository.getProfileByUser(connection.requesterUser.id);
    var profileAddressedUser = await _profileRepository.getProfileByUser(connection.addressed.id);
    
    profileAddressedUser.profile!.connections.add(connection.requesterUser.id);
    profileRequesterUser.profile!.connections.add(connection.addressed.id);


    await Future.wait(
      [
        _profileRepository.updateProfile(profileAddressedUser.profile!),
        _profileRepository.updateProfile(profileRequesterUser.profile!)
      ]
    );

    //criando chat
    await _chatRepository.createChat(relationship.addressed, relationship.requesterUser);
    return relationship;

  }
}
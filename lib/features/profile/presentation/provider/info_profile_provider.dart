import 'package:demopico/features/profile/domain/usecases/persist_bio_uc.dart';
import 'package:demopico/features/profile/domain/usecases/persist_contributions_uc.dart';
import 'package:demopico/features/profile/domain/usecases/persist_photo_uc.dart';
import 'package:demopico/features/profile/domain/usecases/persist_followers_uc.dart';
import 'package:flutter/foundation.dart';

class InfoProfileProvider extends ChangeNotifier {
  static InfoProfileProvider? _profileProvider;

  static InfoProfileProvider get getInstance {
    _profileProvider ??= InfoProfileProvider(
        persistContributionsUc: PersistContributionsUc.getInstance,
        persistFollowersUc: PersistFollowersUc.getInstance,
        persistBioUc: PersistBioUc.getInstance,
        persistPhotoUc: PersistPhotoUc.getInstance);
    return _profileProvider!;
  }

  InfoProfileProvider(
      {required this.persistContributionsUc,
      required this.persistFollowersUc,
      required this.persistBioUc,
      required this.persistPhotoUc});

  final PersistBioUc persistBioUc;
  final PersistContributionsUc persistContributionsUc;
  final PersistPhotoUc persistPhotoUc;
  final PersistFollowersUc persistFollowersUc;
}

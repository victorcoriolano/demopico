import 'package:flutter/foundation.dart';

class InfoProfileProvider extends ChangeNotifier {
  static InfoProfileProvider? _profileProvider;

  static InfoProfileProvider get getInstance {
    _profileProvider ??= InfoProfileProvider(
    );
    return _profileProvider!;
  }

  InfoProfileProvider();

  
}

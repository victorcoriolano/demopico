import 'dart:typed_data';

import 'package:demopico/features/external/enuns/type_content.dart';

abstract class IDangerContentApi{
  TypeContent scanMidia(Uint8List midia);
}
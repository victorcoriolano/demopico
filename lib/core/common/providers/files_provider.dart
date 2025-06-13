import 'package:demopico/core/common/use_case/delete_file_uc.dart';
import 'package:demopico/core/common/use_case/pick_image_uc.dart';
import 'package:demopico/core/common/use_case/save_image_uc.dart';
import 'package:flutter/material.dart';

class FilesProvider extends ChangeNotifier {
  static FilesProvider? _filesProvider;
  static FilesProvider get getInstance {
    _filesProvider ??= FilesProvider(
      pickFiles: PickFileUC.getInstance,
      saveImageUC: SaveImageUC.getInstance,
      deleteFile: DeleteFileUc.instance,
    );
    return _filesProvider!;
  }

  final PickFileUC pickFiles;
  final SaveImageUC saveImageUC;
  final DeleteFileUc deleteFile;

  FilesProvider({required this.pickFiles, required this.saveImageUC, required this.deleteFile});

  
}
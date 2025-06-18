import 'package:demopico/core/common/data/models/upload_file_model.dart';
import 'package:demopico/core/common/data/models/upload_result_file_model.dart';
import 'package:demopico/core/common/usecases/delete_file_uc.dart';
import 'package:demopico/core/common/usecases/pick_image_uc.dart';
import 'package:demopico/core/common/usecases/picke_video_uc.dart';
import 'package:demopico/core/common/usecases/save_image_uc.dart';
import 'package:flutter/material.dart';

class FilesProvider extends ChangeNotifier {
  static FilesProvider? _filesProvider;
  static FilesProvider get getInstance {
    _filesProvider ??= FilesProvider(
      pickFiles: PickFileUC.getInstance,
      saveImageUC: SaveImageUC.getInstance,
      deleteFile: DeleteFileUc.instance,
      pickVideo: PickVideoUC.getInstance,
    );
    return _filesProvider!;
  }

  final PickVideoUC pickVideo;
  final PickFileUC pickFiles;
  final SaveImageUC saveImageUC;
  final DeleteFileUc deleteFile;

  FilesProvider({
    required this.pickFiles, 
    required this.saveImageUC, 
    required this.deleteFile,
    required this.pickVideo});

  List<UploadFileModel> images = [];
  

  List<UploadFileModel> video = [];

  List<UploadResultFileModel> resultsUpload = [];

  Future<void> pickImages() async {
    images = await pickFiles.pick();
    notifyListeners();
  }

  Future<void> pegarVideo() async {
    await pickVideo.call();
    notifyListeners();
  }

  Future<void> saveImage() async {
    resultsUpload = saveImageUC.saveImage(images);
    notifyListeners();
  }
  
}
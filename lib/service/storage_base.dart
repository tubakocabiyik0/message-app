import 'dart:io';

import 'package:image_picker/image_picker.dart';

abstract class StorageBase{
  Future<String> savePhoto(String userId,String fileType,PickedFile photo);

}
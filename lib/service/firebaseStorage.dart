import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_message/service/storage_base.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageService implements StorageBase {
  FirebaseStorage _firebaseStorage=FirebaseStorage.instance;
  StorageReference _storageReference;
  @override
  Future<String> savePhoto(String userId, String fileType, PickedFile photo) async{

    _storageReference=_firebaseStorage.ref().child(userId).child(fileType);
    var storageuploadTask =_storageReference.putFile(File(photo.path));
    var url = await (await storageuploadTask.onComplete).ref.getDownloadURL();
    return url;

  }

}
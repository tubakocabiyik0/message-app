
    import 'package:flutter_message/model/repository.dart';
import 'package:flutter_message/service/AuthwithFirebase.dart';
import 'package:flutter_message/service/fake_service.dart';
import 'package:flutter_message/service/firebaseStorage.dart';
import 'package:flutter_message/service/firestore.dart';
import 'package:get_it/get_it.dart';

GetIt locator=GetIt();

void setUpLocator(){
  locator.registerLazySingleton(() => AuthWithFirebaseAuth());
  locator.registerLazySingleton(() => FakeService());
  locator.registerLazySingleton(() => Repository());
  locator.registerLazySingleton(() => FireStoreAdd());
  locator.registerLazySingleton(() => FirebaseStorageService());
    }
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:get/get.dart';
import 'package:sharetraveyard/utility/app_controller.dart';

class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile(
    String filePath,
    String fileName, 
  ) async {
    AppController appController = Get.put(AppController());

    if (appController.urlImage.isNotEmpty) {
      appController.urlImage.clear();
    }

    File file = File(filePath);

    var referance = storage.ref().child('payment_upload/$fileName');

    try {
      await referance.putFile(file).whenComplete(() async {
        await referance.getDownloadURL().then((value) {
          String urlImage = value;
          print('##7feb urlImage ------> $urlImage');
          appController.urlImage.add(urlImage);
        });
      });
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  Future<firebase_storage.ListResult> listFiles() async {
    firebase_storage.ListResult result =
        await storage.ref('payment_upload').listAll();

    result.items.forEach((firebase_storage.Reference ref) {
      print('Found file: $ref');
    });
    return result;
  }
}



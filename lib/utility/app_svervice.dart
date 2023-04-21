import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharetraveyard/models/associate_model.dart';
import 'package:sharetraveyard/models/iphone_model.dart';
import 'package:sharetraveyard/models/profile_model.dart';
import 'package:sharetraveyard/utility/app_controller.dart';
import 'package:sharetraveyard/utility/app_dialog.dart';

class AppSvervice {
  Future<void> readAllAssociate() async {
    AppController appController = Get.put(AppController());
    if (appController.assosicateModels.isNotEmpty) {
      appController.assosicateModels.clear();
    }

    await FirebaseFirestore.instance
        .collection('associate')
        .get()
        .then((value) {
      for (var element in value.docs) {
        AsscociateModel model = AsscociateModel.fromMap(element.data());
        appController.assosicateModels.add(model);
      }
    });
  }

  Future<void> readAllAssociateId() async {
    AppController appController = Get.put(AppController());
    if (appController.associateIdCurrents.isNotEmpty) {
      appController.associateIdCurrents.clear();
    }
    await FirebaseFirestore.instance
        .collection('associate')
        .get()
        .then((value) {
      for (var element in value.docs) {
        appController.associateIdCurrents.add(element.id);
      }
    });
  }

  Future<IphoneModel> findphotodp1ModelWhareDocId(
      {required String docIdPhoto1,required String collectionProduct}) async {
    print('##2mar docIdPhoto1 $docIdPhoto1');
    var result = await FirebaseFirestore.instance
        .collection(collectionProduct)
        .doc(docIdPhoto1)
        .get();

    IphoneModel iphoneModel = IphoneModel.fromMap(result.data()!);

    print('##2mar iphone ----> ${iphoneModel.toMap()}');

    return iphoneModel;
  }

  Future<void> findProfileUserLogin() async {
    AppController appController = Get.put(AppController());

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? docId = preferences.getString('user');

    await FirebaseFirestore.instance
        .collection('associate')
        .doc(docId)
        .get()
        .then((value) {
      AsscociateModel model = AsscociateModel.fromMap(value.data()!);
      appController.profileAssocicateModels.add(model);
    });
  }

  Future<void> readPhotoPD1({required String nameCollection}) async {
    AppController appController = Get.put(AppController());
    if (appController.iphoneModels.isNotEmpty) {
      appController.iphoneModels.clear();
      appController.docIdPhotopd1s.clear();
      appController.searchIphoneModels.clear();
    }

    print(
        '##mar8 @@@@readPhotoPD1 displaySiteCode ---->${appController.displaySiteCode}');

    await FirebaseFirestore.instance
        .collection(nameCollection)
        .orderBy('model')
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          IphoneModel model = IphoneModel.fromMap(element.data());

          if (!(model.reserve!)) {
            appController.iphoneModels.add(model);
            appController.docIdPhotopd1s.add(element.id);
          }
        }
      }
    });
  }

  Future<void> processFindProfileModels(
      {required String associateID, required BuildContext context}) async {
    AppController appController = Get.put(AppController());
    if (appController.profileModels.isNotEmpty) {
      appController.profileModels.clear();

      appController.doIdAssociates.clear();
    }

    print('##2mar associate ----> $associateID');
    await FirebaseFirestore.instance
        .collection('associate')
        .doc(associateID)
        .collection('profile')
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          ProfileModel model = ProfileModel.fromMap(element.data());

          print('##2mar model ---> ${model.toMap()}');
          appController.profileModels.add(model);
          appController.doIdAssociates.add('associateID');
        }
      } else {
        AppDialog(context: context).normalDialog(
            title: 'User false ',
            subTitle:
                '$associateIDอาจจะผิด หรือ ยังไม่ได้ Create New Register');
      }
    });
  }

  Future<String?> findDocIdSiteCode({required String content}) async {
    String? docIdSiteCode;

    var result = await FirebaseFirestore.instance
        .collection('sitecode')
        .where('name', isEqualTo: content)
        .get();

    if (result.docs.isNotEmpty) {
      for (var element in result.docs) {
        docIdSiteCode = element.id;
      }
    }

    return docIdSiteCode;
  }

  Future<void> readAssociate(
      {required String associateID, required BuildContext context}) async {
    AppController appController = Get.put(AppController());

    if (appController.assosicateModels.isEmpty) {
      appController.assosicateModels.clear();
    }

    await FirebaseFirestore.instance
        .collection('associate')
        .doc(associateID)
        .get()
        .then((value) async {
      print('value ===> ${value.data()}');

      if (value.data() == null) {
        AppDialog(context: context).normalDialog(
            title: 'Associate ID fale', subTitle: 'Plase try Again');
      } else {
        AsscociateModel asscociateModel =
            AsscociateModel.fromMap(value.data()!);

        if (asscociateModel.docIdSiteCode.trim() ==
            appController.chooseDocIdSiteCodes.last.trim()) {
          await FirebaseFirestore.instance
              .collection('associate')
              .doc(associateID)
              .collection('profile')
              .get()
              .then((value) {
            if (value.docs.isEmpty) {
              appController.assosicateModels.add(asscociateModel);
            } else {
              AppDialog(context: context).normalDialog(
                  title: '$associateID นี้ create Account แล้ว',
                  subTitle: 'เปลี่ยน Associate ID ใหม่');
            }
          });
        } else {
          AppDialog(context: context).normalDialog(
              title: 'AssosiciateID ไม่มี ',
              subTitle:
                  'Site ${appController.chooseSiteCode.last} ไม่มี ID นี้');
        }
      } //end if
    });
  }
}

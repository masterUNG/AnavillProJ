import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharetraveyard/models/associate_model.dart';
import 'package:sharetraveyard/models/iphone_model.dart';
import 'package:sharetraveyard/models/profile_model.dart';
import 'package:sharetraveyard/utility/app_controller.dart';
import 'package:sharetraveyard/utility/app_dialog.dart';
import 'package:sharetraveyard/utility/app_dialog1.dart';

import '../models/ped_model.dart';
import '../models/site_code_model.dart';

class AppSvervice {
  AppController appController = Get.put(AppController());

  AsscociateModel? asscociateModel;

  Future<void> processEditProfile(
      {required String docIdProfile,
      required Map<String, dynamic> map,
      required String docIdAssociate}) async {
    FirebaseFirestore.instance
        .collection('associate')
        .doc(docIdAssociate)
        .collection('profile')
        .doc(docIdProfile)
        .update(map);
  }

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
      {required String docIdPhoto1, required String collectionProduct}) async {

    print('##2nov ################## docIdPhoto1 $docIdPhoto1');
    var result = await FirebaseFirestore.instance
        .collection(collectionProduct)
        .doc(docIdPhoto1)
        .get();

    IphoneModel iphoneModel = IphoneModel.fromMap(result.data()!);

    print('##2nov iphone ----> ${iphoneModel.toMap()}');

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

          //ไม่แสดง model ที่ reserve เป็น true
          // if (!(model.reserve!)) {
          //   appController.iphoneModels.add(model);
          //   appController.docIdPhotopd1s.add(element.id);
          // }

          //แสดงหมดทุกตััว
          appController.iphoneModels.add(model);
          appController.docIdPhotopd1s.add(element.id);
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
          appController.docIdProfiles.add(element.id);
        }
      } else {
        AppDialog1(context: context).normalDialog(
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
        print(
            '##29july docIDSite ที่เลือก ---> ${appController.chooseDocIdSiteCodes.last}');

        FirebaseFirestore.instance
            .collection('sitecode')
            .doc(appController.chooseDocIdSiteCodes.last)
            .collection('associateId')
            .where('id', isEqualTo: associateID)
            .get()
            .then((value) {
          print('##29july value at associteId ---->${value.docs}');

          if (value.docs.isEmpty) {
            AppDialog(context: context).normalDialog(
                title: 'ค่า AssociateID ไม่ถูกต้อง',
                subTitle:
                    'ไม่มี $associateID ใน site code ${appController.chooseSiteCode.last}');
          } else {
            appController.checkId.value = false;

            asscociateModel = AsscociateModel(
                admin: 'user',
                name: '',
                lastname: '',
                docIdSiteCode: appController.chooseDocIdSiteCodes.last,
                associateID: associateID);

            FirebaseFirestore.instance
                .collection('associate')
                .doc(associateID)
                .set(asscociateModel!.toMap())
                .then((value) {
              Get.snackbar('STEP1 SUCCEED', ' Go to STEP2',
                  backgroundColor: Colors.red.shade700,
                  colorText: Colors.white);
            });

            // FirebaseFirestore.instance
            //     .collection('associate')
            //     .doc(associateID)
            //     .collection('profile')
            //     .get()
            //     .then((value) {
            //   if (value.docs.isEmpty) {
            //     appController.assosicateModels.add(asscociateModel);
            //   } else {
            //     AppDialog(context: context).normalDialog(
            //         title: '$associateID นี้ create Account แล้ว',
            //         subTitle: 'เปลี่ยน Associate ID ใหม่');
            //   }
            // });
          }
        });
      } else {
        AppDialog(context: context).normalDialog(
            title: 'Associate ID ซ้ำ',
            subTitle: 'เปลี่ยน Associate ID นี่สมัครไปแล้ว');
      } //end if
    });
  }

  Future<void> findCurrenAssociateLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var result = preferences.getString('user');
    if (result != null) {
      print('##29july ---> $result');

      FirebaseFirestore.instance
          .collection('associate')
          .doc(result)
          .get()
          .then((value) {
        AsscociateModel asscociateModel =
            AsscociateModel.fromMap(value.data()!);
        appController.currentAssociateLogin.add(asscociateModel);
      });
    }
  }

  Future<void> findProductPed() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? associateID = preferences.getString('user');

    FirebaseFirestore.instance
        .collection('sitecode')
        .doc(appController.currentAssociateLogin.last.docIdSiteCode)
        .get()
        .then((value) {
      SiteCodeModel siteCodeModel = SiteCodeModel.fromMap(value.data()!);
      appController.collectionPeds.add(siteCodeModel.ped);

      FirebaseFirestore.instance
          .collection(siteCodeModel.ped)
          .get()
          .then((value) {
        if (appController.pedmodels.isNotEmpty) {
          appController.pedmodels.clear();
          appController.docIdPeds.clear();
          appController.reservePeds.clear();
        }

        if (value.docs.isNotEmpty) {
          for (var element in value.docs) {
            PedModel pedModel = PedModel.fromMap(element.data());
            appController.pedmodels.add(pedModel);
            appController.docIdPeds.add(element.id);

            if (pedModel.maps!.isEmpty) {
              appController.reservePeds.add(false);
            } else {
              bool result = false;
              int indexMaps = 0;

              for (var element in pedModel.maps!) {
                if (element['associateID'] == associateID) {
                  DateTime dateTimeReserve = element['timestamp'].toDate();

                  print('dateReserve before ---> $dateTimeReserve');

                  dateTimeReserve = dateTimeReserve.add(Duration(minutes: 3));
                  //ปรับเวลาตรงนี้

                  print('dateReserve after ---> $dateTimeReserve');

                  if (dateTimeReserve.difference(DateTime.now()).inMinutes <
                      0) {
                    //หมดเวลา
                    // pedModel.maps!.removeAt(indexMaps);
                  } else {
                    appController.amountPed.value = element['amount'];
                    //เวลายังไม่หมด รู้ว่า amount เท่าไหร่
                    result = true;
                  }
                }
                indexMaps++;
              }

              appController.reservePeds.add(result);
            }
          }
        }
      });
    });
  }

  Future<IphoneModel> checkBuy(
      {required String collection, required String docId}) async {
    var result = await FirebaseFirestore.instance
        .collection(collection)
        .doc(docId)
        .get();

    IphoneModel iphoneModel = IphoneModel.fromMap(result.data()!);
    print('##10sep buy -----> ${iphoneModel.buy}');

    return iphoneModel;
  }

  Future<void> processEditProduct(
      {required String collection,
      required String docId,
      required Map<String, dynamic> map}) async {
    FirebaseFirestore.instance.collection(collection).doc(docId).update(map);
  }
}

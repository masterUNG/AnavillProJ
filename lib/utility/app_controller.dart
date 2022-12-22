import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:sharetraveyard/models/site_code_model.dart';

class AppController extends GetxController {
  RxList<SiteCodeModel> siteCodeModel = <SiteCodeModel>[].obs;
  RxList<String> chooseSiteCode = <String>[].obs;

  Future<void> readSiteCode() async {
    if (siteCodeModel.isNotEmpty) {
      siteCodeModel.clear();
    }

    await FirebaseFirestore.instance.collection('sitecode').get().then((value) {
      for (var element in value.docs) {
        SiteCodeModel model = SiteCodeModel.fromMap(element.data());
        siteCodeModel.add(model);
      }
    });
  }
}

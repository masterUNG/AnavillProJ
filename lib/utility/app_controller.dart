import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:sharetraveyard/models/question_model.dart';
import 'package:sharetraveyard/models/site_code_model.dart';

class AppController extends GetxController {
  RxInt indexBody = 0.obs;

  RxList<SiteCodeModel> siteCodeModel = <SiteCodeModel>[].obs;
  RxList<String> chooseSiteCode = <String>[].obs;

  RxList<QuestionModel> question1Models = <QuestionModel>[].obs;
  RxList<String> chooseQusetion1s = <String>[].obs;

  Future<void> readQuestion1() async {
    if (question1Models.isEmpty) {
      question1Models.clear();
    }
    await FirebaseFirestore.instance
        .collection('question1')
        .get()
        .then((value) {
      for (var element in value.docs) {
        print('## element --> ${element.data()}');
        QuestionModel model = QuestionModel.fromMap(element.data());
        question1Models.add(model);
      }
      ;
    });
  }

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

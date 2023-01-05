import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:sharetraveyard/models/period1_model.dart';
import 'package:sharetraveyard/models/picture_model.dart';
import 'package:sharetraveyard/models/question2_model.dart';
import 'package:sharetraveyard/models/question_model.dart';
import 'package:sharetraveyard/models/site_code_model.dart';

class AppController extends GetxController {
  RxInt indexBody = 0.obs;

  RxList<SiteCodeModel> siteCodeModel = <SiteCodeModel>[].obs;
  RxList<String> chooseSiteCode = <String>[].obs;

  RxList<QuestionModel> question1Models = <QuestionModel>[].obs;
  RxList<String> chooseQusetion1s = <String>[].obs;

  RxList<Question2Model> question2Models = <Question2Model>[].obs;
  RxList<String> chooseQuestions2 = <String>[].obs;

  RxList<Period1Model> periodModels = <Period1Model>[].obs;
  RxList<String> choosePeriod = <String>[].obs;

  RxList<PictureModel> pictureModels = <PictureModel>[].obs;
  RxList<String> choosePicture = <String>[].obs;

  get data => null;

  Future<void> readPicture() async {
    if (pictureModels.isEmpty) {
      periodModels.clear();
    }

    await FirebaseFirestore.instance.collection('picture').get().then((value) {
      for (var element in value.docs) {
        PictureModel model = PictureModel.fromMap(element.data());
        pictureModels.add(model);
         print('## picture --> ${element.data()}');
      }
    });
  }

  Future<void> readPeriod() async {
    if (periodModels.isEmpty) {
      periodModels.clear();
    }

    await FirebaseFirestore.instance.collection('pperiod1').get().then((value) {
      for (var element in value.docs) {
        Period1Model model = Period1Model.fromMap(element.data());
        periodModels.add(model);
      }
    });
  }

  Future<void> readQuestion2() async {
    if (question2Models.isEmpty) {
      question2Models.clear();
    }

    await FirebaseFirestore.instance
        .collection('question2')
        .get()
        .then((value) {
      for (var element in value.docs) {
        Question2Model model = Question2Model.fromMap(element.data());
        question2Models.add(model);
      }
    });
  }

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

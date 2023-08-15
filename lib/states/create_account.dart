// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharetraveyard/models/check_associate_model.dart';
import 'package:sharetraveyard/models/profile_model.dart';
import 'package:sharetraveyard/states/display_wait_admin.dart';
import 'package:sharetraveyard/utility/app_constant.dart';
import 'package:sharetraveyard/utility/app_controller.dart';
import 'package:sharetraveyard/utility/app_dialog.dart';
import 'package:sharetraveyard/utility/app_svervice.dart';
import 'package:sharetraveyard/widgets/widget_buttom.dart';
import 'package:sharetraveyard/widgets/widget_form.dart';
import 'package:sharetraveyard/widgets/widget_icon_buttom.dart';
import 'package:sharetraveyard/widgets/widget_progress.dart';
import 'package:sharetraveyard/widgets/widget_text.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  AppController controller = Get.put(AppController());

  String? associateId,
      password,
      repassword,
      answer1,
      answer2,
      phone,
      address,
      sitecode,
      uname,
      ulastname;

  @override
  void initState() {
    super.initState();
    controller.readSiteCode();
    controller.readQuestion1();
    controller.readQuestion2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.bgColor,
      appBar: AppBar(
        actions: [
          WidgetIconButtom(
            iconData: Icons.verified,
            color: AppConstant.active,
            pressFunc: () {
              methodVerify(controller, context);
            },
          )
        ],
      ),
      body: GetX(
          init: AppController(),
          builder: (AppController appController) {
            print('## question1 --> ${appController.question1Models}');
            if (appController.question1Models.isNotEmpty) {
              for (var element in appController.question1Models) {
                print('## question --> ${element.question}');
              }
            }
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () =>
                  FocusScope.of(context).requestFocus(FocusScopeNode()),
              child: ListView(
                padding: const EdgeInsets.only(left: 24, right: 24, bottom: 36),
                children: [
                  showHead(),
                  titleStep1(),
                  titleSitecode(),
                  dropdownSitecode(appController),
                  titleassociateID(),
                  formAssociateID(context),
                  displayNameLastName(appController),
                  titlestep2(),
                  passwordFillTwice(),
                  passwordTitle(),
                  password1form(),
                  WidgetText(
                    text: '2nd Time Password :',
                    textStyle: AppConstant().h2Style(),
                  ),
                  WidgetForm(
                    obsecu: true,
                    changFunc: (p0) {
                      repassword = p0.trim();
                      //print("##repassword = ${repassword}");
                    },
                  ),
                  WidgetText(
                    text: 'Name (eng) :',
                    textStyle: AppConstant().h2Style(),
                  ),
                  WidgetForm(changFunc: ((p0) {
                    uname = p0.trim();
                  })),
                  WidgetText(
                    text: 'LastName (eng) :',
                    textStyle: AppConstant().h2Style(),
                  ),
                  WidgetForm(changFunc: ((p0) {
                    ulastname = p0.trim();
                  })),
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: WidgetText(
                      text: 'STEP 3',
                      textStyle: AppConstant().h2Style(),
                    ),
                  ),
                  WidgetText(
                    text: 'Personal Question 1',
                    textStyle: AppConstant().h2Style(),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    margin: const EdgeInsets.only(top: 16, bottom: 16),
                    width: double.infinity,
                    height: 50,
                    decoration: AppConstant().curveBox(),
                    child: appController.question1Models.isEmpty
                        ? const WidgetProgress()
                        : DropdownButton(
                            underline: const SizedBox(),
                            isExpanded: true,
                            hint: WidgetText(text: 'Please Choose Qusetion'),
                            value: appController.chooseQusetion1s.isEmpty
                                ? null
                                : appController.chooseQusetion1s.last,
                            items: appController.question1Models
                                .map(
                                  (element) => DropdownMenuItem(
                                    child: WidgetText(text: element.question),
                                    value: element.question,
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              appController.chooseQusetion1s.add(value!);
                            },
                          ),
                  ),
                  WidgetText(
                    text: 'Personal Answer  1',
                    textStyle: AppConstant().h2Style(),
                  ),
                  WidgetForm(
                    changFunc: (p0) {
                      answer1 = p0.trim();
                      //print("##answer1 = ${answer1}");
                    },
                  ),
                  WidgetText(
                    text: 'Personal Question 2',
                    textStyle: AppConstant().h2Style(),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    margin: const EdgeInsets.only(top: 16, bottom: 16),
                    width: double.infinity,
                    height: 50,
                    decoration: AppConstant().curveBox(),
                    child: appController.question2Models.isEmpty
                        ? const WidgetProgress()
                        : DropdownButton(
                            underline: const SizedBox(),
                            isExpanded: true,
                            hint: WidgetText(text: 'Please Choose Qusetion'),
                            value: appController.chooseQuestions2.isEmpty
                                ? null
                                : appController.chooseQuestions2.last,
                            items: appController.question2Models
                                .map(
                                  (element) => DropdownMenuItem(
                                    child: WidgetText(text: element.ques),
                                    value: element.ques,
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              appController.chooseQuestions2.add(value!);
                            },
                          ),
                  ),
                  WidgetText(
                    text: 'Personal Answer  2',
                    textStyle: AppConstant().h2Style(),
                  ),
                  WidgetForm(
                    changFunc: (p0) {
                      answer2 = p0.trim();
                      //print("##answer2 = ${answer2}");
                    },
                  ),
                  WidgetText(
                    text: 'Input Address ',
                    textStyle: AppConstant().h2Style(),
                  ),
                  WidgetForm(changFunc: ((p0) {
                    address = p0.trim();
                  })),
                  WidgetText(
                    text: 'Input PhoneNumber ',
                    textStyle: AppConstant().h2Style(),
                  ),
                  WidgetForm(changFunc: ((p0) {
                    phone = p0.trim();
                  })),
                  Divider(
                    color: AppConstant.dark,
                    thickness: 1,
                  ),
                  WidgetButtom(
                    label: 'Verify',
                    pressFunc: () {
                      methodVerify(appController, context);
                    },
                  ),
                ],
              ),
            );
          }),
    );
  }

  WidgetForm password1form() {
    return WidgetForm(
      obsecu: true,
      changFunc: (p0) {
        password = p0.trim();
        //print("##password = ${password}");
      },
    );
  }

  WidgetText passwordTitle() {
    return WidgetText(
      text: 'Password :',
      textStyle: AppConstant().h2Style(),
    );
  }

  WidgetText passwordFillTwice() {
    return WidgetText(
      text: 'Password Fill Twice',
      textStyle: AppConstant().h2Style(),
    );
  }

  Container titlestep2() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: WidgetText(
        text: 'STEP 2',
        textStyle: AppConstant().h2Style(),
      ),
    );
  }

  WidgetText titleassociateID() {
    return WidgetText(
      text: 'Associate ID',
      textStyle: AppConstant().h2Style(),
    );
  }

  Widget displayNameLastName(AppController appController) {
    return appController.assosicateModels.isEmpty
        ? const SizedBox()
        : Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: AppConstant().curveBox(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                WidgetText(
                  text: 'Associate Name',
                  textStyle: AppConstant().h2Style(),
                ),
                WidgetText(
                  text: appController.assosicateModels.last.name,
                  textStyle: AppConstant()
                      .h3Style(color: Colors.red, fontWeight: FontWeight.w700),
                ),
                WidgetText(
                  text: 'Associate LastName',
                  textStyle: AppConstant().h2Style(),
                ),
                WidgetText(
                  text: appController.assosicateModels.last.lastname,
                  textStyle: AppConstant()
                      .h3Style(color: Colors.red, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          );
  }

  Widget formAssociateID(BuildContext context) {
    return Obx(() {
      print('${controller.checkId.value}');
      return WidgetForm(
        textInputType: TextInputType.text,
        // sufixWidget: controller.checkId.value
        //     ? WidgetIconButtom(
        //         iconData: Icons.cloud_upload,
        //         color: AppConstant.active,
        //         pressFunc: () {
        //           if (associateId?.isEmpty ?? true) {
        //             AppDialog(context: context).normalDialog(
        //                 title: 'No AssociateId',
        //                 subTitle: 'Plase Fill AssociateID');
        //           } else {
        //             AppSvervice().readAssociate(
        //                 associateID: associateId!, context: context);
        //           }
        //         },
        //       )
        //     : const SizedBox(),
        changFunc: (p0) {
          associateId = p0.trim();
          print("##associateId = ${associateId}");
        },
      );
    });
  }

  Future<void> methodVerify(
      AppController appController, BuildContext context) async {
    if (appController.chooseSiteCode.isEmpty) {
      AppDialog(context: context).normalDialog(
          title: 'Site Code ?', subTitle: 'Please choose Site code');
    } else if (associateId?.isEmpty ?? true) {
      AppDialog(context: context).normalDialog(
          title: 'No Associate', subTitle: 'Plase Fill Associate ID');
    } else if ((uname?.isEmpty ?? true) || (ulastname?.isEmpty ?? true)) {
      AppDialog(context: context).normalDialog(
          title: 'No Name, Surname', subTitle: 'PleaseTap Cluod Icon');
    } else if ((password?.isEmpty ?? true) || (repassword?.isEmpty ?? true)) {
      AppDialog(context: context).normalDialog(
          title: 'Password, RePassword', subTitle: 'please fill password');
    } else if (password != repassword) {
      AppDialog(context: context).normalDialog(
          title: 'Password Not Math',
          subTitle: 'Password not Equire Repassword');
    } else if (appController.chooseQusetion1s.isEmpty) {
      AppDialog(context: context).normalDialog(
          title: 'Question 1', subTitle: 'please Choose Question 1');
    } else if (answer1?.isEmpty ?? true) {
      AppDialog(context: context)
          .normalDialog(title: 'Answer1 ?', subTitle: 'Plase Fill amnswer1');
    } else if (appController.chooseQuestions2.isEmpty) {
      AppDialog(context: context).normalDialog(
          title: 'Question2 ?', subTitle: 'please Choose Question 2');
    } else if (answer2?.isEmpty ?? true) {
      AppDialog(context: context)
          .normalDialog(title: 'Answer2 ?', subTitle: 'Plase Fill amnswer2');
    } else if ((address?.isEmpty ?? true) || (phone?.isEmpty ?? true)) {
      AppDialog(context: context).normalDialog(
          title: 'Address, phone', subTitle: 'pleas Fill address phone');
    } else {
      ProfileModel profileModel = ProfileModel(
          password: password!,
          question1: appController.chooseQusetion1s.last,
          answer1: answer1!,
          question2: appController.chooseQuestions2.last,
          answer2: answer2!,
          phone: phone!,
          address: address!,
          sitecode: appController.chooseSiteCode.last,
          uname: uname!,
          ulastname: ulastname!);

      print('##29july profileModel --> ${profileModel.toMap()}');
      CheckAssociateModel checkAssociateModel = CheckAssociateModel(
          mapProfile: profileModel.toMap(),
          timestamp: Timestamp.fromDate(DateTime.now()),
          cheeck: false,
          associateId: associateId!,
          docIdSiteCode: appController.docIdSiteCodes.last);

      DocumentReference documentReference =
          FirebaseFirestore.instance.collection('checkassociate').doc();

      await documentReference
          .set(checkAssociateModel.toMap())
          .then((value) async {
        String docIdCheckAssociate = documentReference.id;
        print('##docId-----> $docIdCheckAssociate');

        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences
            .setString('docIdCheckAssociate', docIdCheckAssociate)
            .then((value) {
          Get.offAll(const DisplayWaitAdmin());
        });
      });

      // await FirebaseFirestore.instance
      //     .collection('associate')
      //     .doc(associateId)
      //     .collection('profile')
      //     .doc()
      //     .set(profileModel.toMap())
      //     .then((value) {
      //   AsscociateModel asscociateModel = AsscociateModel(
      //       admin: 'user',
      //       name: uname!,
      //       lastname: ulastname!,
      //       docIdSiteCode: controller.chooseDocIdSiteCodes.last,
      //       associateID: associateId!,
      //       shopPhone: true,
      //       shopPed: false);
      //   Map<String, dynamic> map = asscociateModel.toMap();

      //   FirebaseFirestore.instance
      //       .collection('associate')
      //       .doc(associateId)
      //       .update(map)
      //       .then((value) => Get.back());
      // });
    }
  }

  Container dropdownSitecode(AppController appController) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.only(top: 16, bottom: 16),
      width: double.infinity,
      height: 50,
      decoration: AppConstant().curveBox(),
      child: appController.siteCodeModel.isEmpty
          ? const WidgetProgress()
          : Center(
              child: DropdownButton(
                underline: const SizedBox(),
                isExpanded: true,
                hint: const WidgetText(text: 'Palease Choose Site Code'),
                value: appController.chooseSiteCode.isEmpty
                    ? null
                    : appController.chooseSiteCode.last,
                items: appController.siteCodeModel
                    .map(
                      (element) => DropdownMenuItem(
                        child: WidgetText(text: element.name),
                        value: element.name,
                      ),
                    )
                    .toList(),
                onChanged: (value) async {
                  appController.chooseSiteCode.add(value!);
                  await AppSvervice()
                      .findDocIdSiteCode(content: value)
                      .then((value) {
                    String? docIdSiteCode = value;

                    print('docIdSiteCode --- > $docIdSiteCode');

                    if (docIdSiteCode != null) {
                      appController.chooseDocIdSiteCodes.add(docIdSiteCode);
                    }
                  });
                },
              ),
            ),
    );
  }

  WidgetText titleSitecode() {
    return WidgetText(
      text: 'Site Code',
      textStyle: AppConstant().h2Style(),
    );
  }

  Container titleStep1() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: WidgetText(
        text: 'STEP 1',
        textStyle: AppConstant().h2Style(),
      ),
    );
  }

  Row showHead() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 24),
          child: WidgetText(
            text: 'Registration',
            textStyle: AppConstant().h1Style(),
          ),
        ),
      ],
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharetraveyard/models/check_associate_model.dart';
import 'package:sharetraveyard/state_web/create_account_web.dart';
import 'package:sharetraveyard/state_web/display_wait_admin_web.dart';
import 'package:sharetraveyard/state_web/select_site_web.dart';
import 'package:sharetraveyard/states/create_account.dart';
import 'package:sharetraveyard/states/display_check_associate.dart';
import 'package:sharetraveyard/states/display_wait_admin.dart';
import 'package:sharetraveyard/states/qurstion_forgot.dart';
import 'package:sharetraveyard/states/select_site.dart';
import 'package:sharetraveyard/utility/app_controller.dart';
import 'package:sharetraveyard/utility/app_dialog.dart';
import 'package:sharetraveyard/utility/app_dialog1.dart';
import 'package:sharetraveyard/utility/app_dialog_password.dart';
import 'package:sharetraveyard/utility/app_svervice.dart';
import 'package:sharetraveyard/widgets/widget_buttom.dart';
import 'package:sharetraveyard/widgets/widget_form.dart';
import 'package:sharetraveyard/widgets/widget_text.dart';
import 'package:sharetraveyard/widgets/widget_text_buttom.dart';

import '../utility/app_constant.dart';

class AuthenMobileWeb extends StatefulWidget {
  const AuthenMobileWeb({super.key});

  @override
  State<AuthenMobileWeb> createState() => _AuthenMobileWebState();
}

class _AuthenMobileWebState extends State<AuthenMobileWeb> {
  String? user, password;

  int i = 1;

  @override
  void initState() {
    super.initState();

    AppSvervice().readAllAssociateId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.bgColor,
      body: SafeArea(
        child: LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
          return GetX(
              init: AppController(),
              builder: (AppController appController) {
                print(
                    'associate ---->${appController.associateIdCurrents.length}');
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () =>
                      FocusScope.of(context).requestFocus(FocusScopeNode()),
                  child: Center(
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: 300,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            WidgetText(
                              text: 'LOG IN',
                              textStyle: AppConstant().h1Style(),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 60),
                              width: boxConstraints.maxWidth * 0.8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  WidgetText(
                                    text: 'Associate ID',
                                    textStyle: AppConstant().h2Style(),
                                  ),
                                  WidgetForm(
                                    changFunc: (p0) {
                                      user = p0.trim();
                                    },
                                  ),
                                  WidgetText(
                                    text: 'Password',
                                    textStyle: AppConstant().h2Style(),
                                  ),
                                  WidgetForm(
                                    obsecu: true,
                                    changFunc: (p0) {
                                      password = p0.trim();
                                    },
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      loginButton(boxConstraints,
                                          appController: appController),
                                    ],
                                  ),
                                  Divider(
                                    color: AppConstant.dark,
                                    thickness: 1,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          textOR(),
                                          //ButtonGoogle(),
                                          buttomCreateRegister(),
                                          buttonCreateForgetpassword(
                                              appController: appController),
                                          WidgetTextButtom(
                                            label: 'ติดตามผลการสมัคร',
                                            pressFunc: () {
                                              String? docIdAssocate;

                                              AppDialog(context: context)
                                                  .normalDialog(
                                                      title:
                                                          'ติดตามผล โปรดกรอก docIdAssocate ที่เคยสมัครไว้',
                                                      subTitle:
                                                          'โปรดกรอก docIdAssocate ที่เคยสมัครไว้',
                                                      contenWidget: Container(
                                                        width: 250,
                                                        child: WidgetForm(
                                                          changFunc: (p0) {
                                                            docIdAssocate = p0;
                                                          },
                                                        ),
                                                      ),
                                                      action2Widget:
                                                          WidgetButtom(
                                                        label: 'เช็คผล',
                                                        pressFunc: () async {
                                                          if (docIdAssocate
                                                                  ?.isEmpty ??
                                                              true) {
                                                            Get.back();
                                                            Get.snackbar(
                                                                'ยังไม่ได้กรอก',
                                                                'docIdAssocate');
                                                          } else {
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'checkassociate')
                                                                .where('associateId',isEqualTo:docIdAssocate)
                                                                .get()
                                                                .then((value) {
                                                              if (value.docs
                                                                  .isEmpty) {
                                                                Get.back();
                                                                Get.snackbar(
                                                                    'docIdAssociate ผิด',
                                                                    'กรุณากรอกใหม่');
                                                              } else {
                                                                for (var element
                                                                    in value
                                                                        .docs) {
                                                                  CheckAssociateModel
                                                                      checkAssociateModel =
                                                                      CheckAssociateModel.fromMap(
                                                                          element
                                                                              .data());

                                                                  if ((checkAssociateModel
                                                                          .cheeck) &&
                                                                      (checkAssociateModel
                                                                          .resultAdmin!)) {
                                                                    Get.back();
                                                                    Get.to(DisplayCheckAssociate(
                                                                        checkAssociateModel:
                                                                            checkAssociateModel, fromWeb: true,));
                                                                  } else {
                                                                    Get.back();
                                                                    Get.to(
                                                                        DisplayWaitAdminWeb(
                                                                      docIdAssociate:
                                                                          element
                                                                              .id,
                                                                    ));
                                                                  }
                                                                }
                                                              }
                                                            });
                                                          }
                                                        },
                                                      ));
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        }),
      ),
    );
  }

  WidgetButtom loginButton(BoxConstraints boxConstraints,
      {required AppController appController}) {
    return WidgetButtom(
      size: 300,
      label: 'Login',
      pressFunc: () async {
        if ((user?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
          AppDialog1(context: context).normalDialog(
              title: 'Have Space', subTitle: 'Please Fill every blank');
        } else {
          await AppSvervice()
              .processFindProfileModels(associateID: user!, context: context)
              .then((value) async {
            if (appController.profileModels.isNotEmpty) {
              if (appController.profileModels.last.approve) {
                int timesPasswordFalse = AppConstant.timePasswordFalse;

                if (password == appController.profileModels.last.password) {
                  //password true

                  await GetStorage().write('user', user).then((value) {
                    Get.off(SelectSiteWeb(
                      assoiate: user!,
                    ));
                  });

                  // SharedPreferences preferences =
                  //     await SharedPreferences.getInstance();
                  // preferences.setString('user', user!).then((value) {
                  //   Get.off(SelectSite(
                  //     assoiate: user!,
                  //   ));
                  // });
                } else {
                  if (i <= timesPasswordFalse) {
                    AppDialog1(context: context).normalDialog(
                        title: 'Password False ครั้งที่ $i',
                        subTitle: 'Please try again');
                  } else {
                    Map<String, dynamic> map =
                        appController.profileModels.last.toMap();
                    print('##28june map before at authen mobile--> $map');
                    map['approve'] = false;
                    print('##28june map after at authen mobile--> $map');
                    print(
                        '##28june docIdProfiles --->${appController.docIdProfiles.last}');

                    AppSvervice()
                        .processEditProfile(
                            docIdProfile: appController.docIdProfiles.last,
                            map: map,
                            docIdAssociate: user!)
                        .then((value) {
                      AppDialog(context: context).normalDialog(
                          title: ' Wrong Password more than  5 times',
                          subTitle: 'Please Contact admin unlock password ');
                    });
                  }

                  i++;
                }
              } else {
                AppDialog(context: context).normalDialog(
                    title: ' Wrong Password more than  5 times',
                    subTitle: 'Please Contact admin unlock password ');
              }
            }
          });
        }
      },
    );
  }

  WidgetText textOR() {
    return WidgetText(
      text: 'OR',
      textStyle: AppConstant().h2Style(),
    );
  }

  WidgetTextButtom buttonCreateForgetpassword(
      {required AppController appController}) {
    String? associateId;
    return WidgetTextButtom(
      label: 'Forgot Password',
      pressFunc: () {
        AppDialogPassword(context: context).normalDialog(
            title: 'Fill Associate ID',
            subTitle: '',
            contenWidgetPassword: WidgetForm(
              changFunc: (p0) {
                associateId = p0.trim();
              },
              textInputType: TextInputType.text,
            ),
            action2WidgetPassword: Column(
              children: [
                WidgetButtom(
                  label: 'Forgot',
                  pressFunc: () {
                    Get.back;
                    if (associateId?.isEmpty ?? true) {
                      Get.snackbar(
                        'Have Space ',
                        'Please Fill Assocate ID',
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    } else {
                      if (appController.associateIdCurrents
                          .contains(associateId)) {
                        Get.offAll(
                            QuestionForgot(docIdAssociate: associateId!));
                      } else {
                        Get.snackbar(
                          '$associateId False  ',
                          'NO This Associate ID',
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      }
                    }
                  },
                ),
              ],
            ));
      },
    );
  }

  WidgetTextButtom buttomCreateRegister() {
    return WidgetTextButtom(
      label: 'Create New Register',
      pressFunc: () async {
        Get.to(const CreateAccountWeb());

        SharedPreferences preferences = await SharedPreferences.getInstance();
        String? docId = preferences.getString('docIdCheckAssociate');

        // if (docId == null) {
        //   Get.to(const CreateAccount());
        // } else {
        //   FirebaseFirestore.instance
        //       .collection('checkassociate')
        //       .doc(docId)
        //       .get()
        //       .then((value) {
        //     CheckAssociateModel checkAssociateModel =
        //         CheckAssociateModel.fromMap(value.data()!);

        //     if ((checkAssociateModel.cheeck)&&(checkAssociateModel.resultAdmin ?? true)) {
        //       Get.to( DisplayCheckAssociate(checkAssociateModel: checkAssociateModel,));
        //     } else {
        //       Get.to(const DisplayWaitAdmin());
        //     }
        //   });
        // }
      },
    );
  }
}

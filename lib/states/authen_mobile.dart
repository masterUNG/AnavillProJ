import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharetraveyard/states/create_account.dart';
import 'package:sharetraveyard/states/qurstion_forgot.dart';
import 'package:sharetraveyard/states/select_site.dart';
import 'package:sharetraveyard/utility/app_controller.dart';
import 'package:sharetraveyard/utility/app_dialog.dart';
import 'package:sharetraveyard/utility/app_svervice.dart';
import 'package:sharetraveyard/widgets/widget_buttom.dart';
import 'package:sharetraveyard/widgets/widget_form.dart';
import 'package:sharetraveyard/widgets/widget_text.dart';
import 'package:sharetraveyard/widgets/widget_text_buttom.dart';

import '../utility/app_constant.dart';

class AuthenMobile extends StatefulWidget {
  const AuthenMobile({super.key});

  @override
  State<AuthenMobile> createState() => _AuthenMobileState();
}

class _AuthenMobileState extends State<AuthenMobile> {
  String? user, password;

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
                                  text: 'User Name',
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
                                        ButtomCreateRegister(),
                                        buttonCreateForgetpassword(
                                            appController: appController)
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
                );
              });
        }),
      ),
    );
  }

  WidgetButtom loginButton(BoxConstraints boxConstraints,
      {required AppController appController}) {
    return WidgetButtom(
      size: boxConstraints.maxWidth * 0.6,
      label: 'Login',
      pressFunc: () async {
        if ((user?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
          AppDialog(context: context).normalDialog(
              title: 'Have Space', subTitle: 'plase Fill every blank');
        } else {
          await AppSvervice()
              .processFindProfileModels(associateID: user!, context: context)
              .then((value) async {
            if (appController.profileModels.isNotEmpty) {
              if (password == appController.profileModels.last.password) {
                //password true

                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                preferences.setString('user', user!).then((value) {
                  Get.off(const SelectSite());
                });
              } else {
                AppDialog(context: context).normalDialog(
                    title: 'password false', subTitle: 'plase try again');
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
        AppDialog(context: context).normalDialog(
            title: 'Fill Associate ID',
            subTitle: '',
            contenWidget: WidgetForm(
              changFunc: (p0) {
                associateId = p0.trim();
              },
              textInputType: TextInputType.number,
            ),
            actionWidget: Column(
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
                      if (appController.associateIdCurrents.contains(associateId)) {
                        Get.offAll(QuestionForgot(docIdAssociate: associateId!));
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

  WidgetTextButtom ButtomCreateRegister() {
    return WidgetTextButtom(
      label: 'Create New Register',
      pressFunc: () {
        Get.to(const CreateAccount());
      },
    );
  }
}

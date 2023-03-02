// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharetraveyard/states/authen_mobile.dart';
import 'package:sharetraveyard/utility/app_constant.dart';
import 'package:sharetraveyard/utility/app_controller.dart';
import 'package:sharetraveyard/utility/app_dialog.dart';
import 'package:sharetraveyard/utility/app_svervice.dart';
import 'package:sharetraveyard/widgets/widget_buttom.dart';
import 'package:sharetraveyard/widgets/widget_form.dart';
import 'package:sharetraveyard/widgets/widget_text.dart';

class QuestionForgot extends StatefulWidget {
  const QuestionForgot({
    Key? key,
    required this.docIdAssociate,
  }) : super(key: key);

  final String docIdAssociate;

  @override
  State<QuestionForgot> createState() => _QuestionForgotState();
}

class _QuestionForgotState extends State<QuestionForgot> {
  String? answer1, answer2;
  @override
  void initState() {
    super.initState();
    AppSvervice().processFindProfileModels(
        associateID: widget.docIdAssociate, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.bgColor,
      appBar: AppBar(
        title: WidgetText(
          text: 'Forgot Password',
          textStyle: AppConstant().h2Style(),
        ),
      ),
      body: GetX(
          init: AppController(),
          builder: (AppController appController) {
            print('##2mar profile --- >${appController.profileModels.length}');
            return appController.profileModels.isEmpty
                ? const SizedBox()
                : ListView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    children: [
                      WidgetText(
                        text: 'Question1 :',
                        textStyle: AppConstant().h2Style(),
                      ),
                      WidgetText(
                          text: appController.profileModels.last.question1),
                      WidgetForm(
                        changFunc: (p0) {
                          answer1 = p0.trim();
                        },
                      ),
                      WidgetText(
                        text: 'Question2 :',
                        textStyle: AppConstant().h2Style(),
                      ),
                      WidgetText(
                          text: appController.profileModels.last.question2),
                      WidgetForm(
                        changFunc: (p0) {
                          answer2 = p0.trim();
                        },
                      ),
                      WidgetButtom(
                        label: 'ForgotPassword',
                        pressFunc: () {
                          if ((answer1?.isEmpty ?? true) ||
                              (answer2?.isEmpty ?? true)) {
                            AppDialog(context: context).normalDialog(
                                title: 'Have Space',
                                subTitle: 'Please fill every ');
                          }
                          if (answer1 !=
                              appController.profileModels.last.answer1) {
                            AppDialog(context: context).normalDialog(
                                title: 'Answer 1 false',
                                subTitle: 'please try agin');
                          }
                          if (answer2 !=
                              appController.profileModels.last.answer2) {
                            AppDialog(context: context).normalDialog(
                                title: 'Answer 2 false',
                                subTitle: 'please try agin');
                          } else {
                            AppDialog(context: context).normalDialog(
                                title: 'password',
                                subTitle:
                                    appController.profileModels.last.password,
                                actionWidget: WidgetButtom(
                                  label: 'Authen',
                                  pressFunc: () {
                                    Get.offAll(const AuthenMobile());
                                  },
                                ));
                          }
                        },
                      )
                    ],
                  );
          }),
    );
  }
}

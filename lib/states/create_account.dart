import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharetraveyard/utility/app_constant.dart';
import 'package:sharetraveyard/utility/app_controller.dart';
import 'package:sharetraveyard/utility/app_dialog.dart';
import 'package:sharetraveyard/widgets/widget_buttom.dart';
import 'package:sharetraveyard/widgets/widget_form.dart';
import 'package:sharetraveyard/widgets/widget_progress.dart';
import 'package:sharetraveyard/widgets/widget_text.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  AppController controller = Get.put(AppController());

  String? associateId, name, lastName, password, repassword, answer1, answer2;

  @override
  void initState() {
    super.initState();
    controller.readSiteCode();
    controller.readQuestion1();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.bgColor,
      appBar: AppBar(),
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
                  WidgetText(
                    text: 'Associate ID',
                    textStyle: AppConstant().h2Style(),
                  ),
                  WidgetForm(
                    textInputType: TextInputType.number,
                    changFunc: (p0) {
                      associateId = p0.trim();
                    },
                  ),
                  WidgetText(
                    text: 'Associate Name',
                    textStyle: AppConstant().h2Style(),
                  ),
                  WidgetForm(
                    changFunc: (p0) {
                      name = p0.trim();
                    },
                  ),
                  WidgetText(
                    text: 'Associate LastName',
                    textStyle: AppConstant().h2Style(),
                  ),
                  WidgetForm(
                    changFunc: (p0) {
                      lastName = p0.trim();
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: WidgetText(
                      text: 'STEP 2',
                      textStyle: AppConstant().h2Style(),
                    ),
                  ),
                  WidgetText(
                    text: 'Password Fill Twice',
                    textStyle: AppConstant().h2Style(),
                  ),
                  WidgetText(
                    text: 'Password :',
                    textStyle: AppConstant().h2Style(),
                  ),
                  WidgetForm(
                    changFunc: (p0) {
                      password = p0.trim();
                    },
                  ),
                  WidgetText(
                    text: '2nd Time Password :',
                    textStyle: AppConstant().h2Style(),
                  ),
                  WidgetForm(
                    obsecu: true,
                    changFunc: (p0) {
                      repassword = p0.trim();
                    },
                  ),
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
                    color: AppConstant.fieldColor,
                    child: appController.question1Models.isEmpty
                        ? const WidgetProgress()
                        : DropdownButton(
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
                    },
                  ),
                  WidgetText(
                    text: 'Personal Question 2',
                    textStyle: AppConstant().h2Style(),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 16, bottom: 16),
                    width: double.infinity,
                    height: 50,
                    color: AppConstant.fieldColor,
                  ),
                  WidgetText(
                    text: 'Personal Answer  2',
                    textStyle: AppConstant().h2Style(),
                  ),
                  WidgetForm(
                    changFunc: (p0) {
                      answer2 = p0.trim();
                    },
                  ),
                  Divider(
                    color: AppConstant.dark,
                    thickness: 1,
                  ),
                  WidgetButtom(
                    label: 'Verify',
                    pressFunc: () {
                      if (appController.chooseSiteCode.isEmpty) {
                        AppDialog(context: context).normalDialog(
                            title: 'Site Code ?',
                            subTitle: 'Please csoose Site code');
                      } else if ((associateId?.isEmpty ?? true) ||
                          (name?.isEmpty ?? true) ||
                          (lastName?.isEmpty ?? true) ||
                          (password?.isEmpty ?? true) ||
                          (repassword?.isEmpty ?? true) ||
                          (answer1?.isEmpty ?? true) ||
                          (answer2?.isEmpty ?? true)) {
                        AppDialog(context: context).normalDialog(
                            title: 'have space ?',
                            subTitle: 'please fill every blank');
                      } else if (appController.chooseQusetion1s.isEmpty) {
                        AppDialog(context: context).normalDialog(
                            title: 'Question 1',
                            subTitle: 'please Choose Question 1');
                      }
                    },
                  )
                ],
              ),
            );
          }),
    );
  }

  Container dropdownSitecode(AppController appController) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.only(top: 16, bottom: 16),
      width: double.infinity,
      height: 50,
      color: AppConstant.fieldColor,
      child: appController.siteCodeModel.isEmpty
          ? const WidgetProgress()
          : Center(
              child: DropdownButton(
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
                onChanged: (value) {
                  appController.chooseSiteCode.add(value!);
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

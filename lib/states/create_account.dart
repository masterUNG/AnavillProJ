import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharetraveyard/utility/app_constant.dart';
import 'package:sharetraveyard/utility/app_controller.dart';
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
  @override
  void initState() {
    super.initState();
    controller.readSiteCode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.bgColor,
      appBar: AppBar(),
      body: GetX(
          init: AppController(),
          builder: (AppController appController) {
            print('## siteCodeModel =${appController.siteCodeModel}');
            return ListView(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 36),
              children: [
                showHead(),
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: WidgetText(
                    text: 'STEP 1',
                    textStyle: AppConstant().h2Style(),
                  ),
                ),
                WidgetText(
                  text: 'Site Code',
                  textStyle: AppConstant().h2Style(),
                ),
                Container(padding:  const EdgeInsets.symmetric(horizontal: 16),
                  margin: const EdgeInsets.only(top: 16, bottom: 16),
                  width: double.infinity,
                  height: 50,
                  color: AppConstant.fieldColor,
                  child: appController.siteCodeModel.isEmpty
                      ? const WidgetProgress()
                      : Center(
                          child: DropdownButton(isExpanded: true,
                            hint: const WidgetText(
                                text: 'Palease Choose Site Code'),
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
                ),
                WidgetText(
                  text: 'Associate ID',
                  textStyle: AppConstant().h2Style(),
                ),
                WidgetForm(
                  changFunc: (p0) {},
                ),
                WidgetText(
                  text: 'Associate Name',
                  textStyle: AppConstant().h2Style(),
                ),
                WidgetForm(
                  changFunc: (p0) {},
                ),
                WidgetText(
                  text: 'Associate LastName',
                  textStyle: AppConstant().h2Style(),
                ),
                WidgetForm(
                  changFunc: (p0) {},
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
                  changFunc: (p0) {},
                ),
                WidgetText(
                  text: '2nd Time Password :',
                  textStyle: AppConstant().h2Style(),
                ),
                WidgetForm(
                  obsecu: true,
                  changFunc: (p0) {},
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
                  margin: const EdgeInsets.only(top: 16, bottom: 16),
                  width: double.infinity,
                  height: 50,
                  color: AppConstant.fieldColor,
                ),
                WidgetText(
                  text: 'Personal Answer  1',
                  textStyle: AppConstant().h2Style(),
                ),
                WidgetForm(
                  changFunc: (p0) {},
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
                  changFunc: (p0) {},
                ),
                Divider(
                  color: AppConstant.dark,
                  thickness: 1,
                ),
                WidgetButtom(
                  label: 'Verify',
                  pressFunc: () {},
                )
              ],
            );
          }),
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

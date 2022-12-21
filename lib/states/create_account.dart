import 'package:flutter/material.dart';
import 'package:sharetraveyard/utility/app_constant.dart';
import 'package:sharetraveyard/widgets/widget_buttom.dart';
import 'package:sharetraveyard/widgets/widget_form.dart';
import 'package:sharetraveyard/widgets/widget_text.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.bgColor,
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.only(left: 24,right: 24,bottom: 36),
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
          Container(
            margin: const EdgeInsets.only(top: 16, bottom: 16),
            width: double.infinity,
            height: 50,
            color: AppConstant.fieldColor,
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

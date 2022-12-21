import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharetraveyard/states/create_account.dart';
import 'package:sharetraveyard/utility/app_controller.dart';
import 'package:sharetraveyard/widgets/widget_buttom.dart';
import 'package:sharetraveyard/widgets/widget_form.dart';
import 'package:sharetraveyard/widgets/widget_text.dart';
import 'package:sharetraveyard/widgets/widget_text_buttom.dart';

import '../utility/app_constant.dart';

class AuthenMobile extends StatelessWidget {
  const AuthenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.bgColor,
      body: SafeArea(
        child: LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
            child: Center(
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
                          changFunc: (p0) {},
                        ),
                        WidgetText(
                          text: 'Password',
                          textStyle: AppConstant().h2Style(),
                        ),
                        WidgetForm(
                          obsecu: true,
                          changFunc: (p0) {},
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            WidgetButtom(
                              size: boxConstraints.maxWidth * 0.6,
                              label: 'Login',
                              pressFunc: () {},
                            ),
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
                                WidgetText(
                                  text: 'OR',
                                  textStyle: AppConstant().h2Style(),
                                ),
                                WidgetTextButtom(
                                  label: 'Create New Register',
                                  pressFunc: () {
                                    Get.to(const CreateAccount());
                                  },
                                ),
                                WidgetTextButtom(
                                  label: 'Forgot Password',
                                  pressFunc: () {},
                                )
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
          );
        }),
      ),
    );
  }
}

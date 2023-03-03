import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharetraveyard/states/main_home_web.dart';
import 'package:sharetraveyard/utility/app_constant.dart';
import 'package:sharetraveyard/utility/app_dialog.dart';
import 'package:sharetraveyard/widgets/widget_buttom.dart';
import 'package:sharetraveyard/widgets/widget_form.dart';
import 'package:sharetraveyard/widgets/widget_text.dart';

class Authenweb extends StatefulWidget {
  const Authenweb({super.key});

  @override
  State<Authenweb> createState() => _AuthenwebState();
}

class _AuthenwebState extends State<Authenweb> {
  String? email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.bgColor,
      appBar: AppBar(
        title: WidgetText(text: 'Authen for admin'),
        titleTextStyle: AppConstant().h2Style(),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 36),
            width: 250,
            child: Column(
              children: [
                WidgetForm(
                  changFunc: (p0) {
                    email = p0.trim();
                  },
                  sufixWidget: const Icon(Icons.email_outlined),
                ),
                WidgetForm(
                  changFunc: (p0) {
                    password = p0.trim();
                  },
                  sufixWidget: const Icon(Icons.lock_outline),
                  obsecu: true,
                ),
                WidgetButtom(
                  label: 'Login',
                  pressFunc: () async {
                    if ((email?.isEmpty ?? true) ||
                        (password?.isEmpty ?? true)) {
                      AppDialog(context: context).normalDialog(
                          title: 'Have space',
                          subTitle: 'please Fill Every blank');
                    } else {
                      await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: email!, password: password!)
                          .then((value) {
                        Get.offAll(const MainHomeWeb());
                      }).catchError((onError) {
                        AppDialog(context: context).normalDialog(
                            title: onError.code, subTitle: onError.code);
                      });
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

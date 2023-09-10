// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharetraveyard/utility/app_constant.dart';
import 'package:sharetraveyard/widgets/widget_buttom.dart';
import 'package:sharetraveyard/widgets/widget_text.dart';

class AppDialogPassword {
  final BuildContext context;
  AppDialogPassword({
    required this.context,
  });

  void normalDialog({
    required String title,
    required String subTitle,
    Widget? actionWidgetPassword,
    Widget? oneActionWidgetPassword,
    Widget? action2WidgetPassword,
    Widget? contenWidgetPassword,
  }) {
    Get.dialog(
      AlertDialog(
        icon: Icon(
          Icons.person,
          color: AppConstant.active1,
          size: 70,
        ),
        title: WidgetText(
          text: title,
          textStyle: AppConstant().h2Style(),
        ),
        content: contenWidgetPassword ?? WidgetText(text: subTitle),
        actions: [
          actionWidgetPassword ?? const SizedBox(),
          action2WidgetPassword ?? const SizedBox(),
          oneActionWidgetPassword ??
              Column(
                children: [
                  WidgetButtom(
                    label: action2WidgetPassword == null ? 'OK' : 'Cancel',
                    pressFunc: () => Get.back(),
                  ),
                ],
              )
        ],
      ),
      barrierDismissible: false,
    );
  }
}

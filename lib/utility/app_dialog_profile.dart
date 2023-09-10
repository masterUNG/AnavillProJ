// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharetraveyard/utility/app_constant.dart';
import 'package:sharetraveyard/widgets/widget_buttom.dart';
import 'package:sharetraveyard/widgets/widget_text.dart';

class AppDialogProfile {
  final BuildContext context;
  AppDialogProfile({
    required this.context,
  });

  void normalDialog({
    required String title,
    required String subTitle,
    Widget? actionWidgetProfile,
    Widget? oneActionWidgetProfile,
    Widget? action2WidgetProfile,
    Widget? contenWidgetProfile,
  }) {
    Get.dialog(
      AlertDialog(
        icon: Icon(
          Icons.account_box,
          color: AppConstant.active1,
          size: 70,
        ),
        title: WidgetText(
          text: title,
          textStyle: AppConstant().h2Style(),
        ),
        content: contenWidgetProfile ?? WidgetText(text: subTitle),
        actions: [
          actionWidgetProfile ?? const SizedBox(),
          action2WidgetProfile ?? const SizedBox(),
          oneActionWidgetProfile ??
              Column(
                children: [
                  WidgetButtom(
                    label: action2WidgetProfile == null ? 'OK' : 'Cancel',
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

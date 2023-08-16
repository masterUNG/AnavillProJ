// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharetraveyard/utility/app_constant.dart';
import 'package:sharetraveyard/widgets/widget_buttom.dart';
import 'package:sharetraveyard/widgets/widget_text.dart';

class AppDialog {
  final BuildContext context;
  AppDialog({
    required this.context,
  });

  void normalDialog({
    required String title,
    required String subTitle,
    Widget? actionWidget,
    Widget? oneActionWidget,
    Widget? action2Widget,
    Widget? contenWidget,
  }) {
    Get.dialog(
      AlertDialog(
        icon: Icon(
          Icons.dangerous,
          color: AppConstant.active,
          size: 48,
        ),
        title: WidgetText(
          text: title,
          textStyle: AppConstant().h2Style(),
        ),
        content: contenWidget ?? WidgetText(text: subTitle),
        actions: [
          actionWidget ?? const SizedBox(),
          action2Widget ?? const SizedBox(),
          oneActionWidget ??
              Column(
                children: [
                  WidgetButtom(
                    label: action2Widget == null ? 'OK' : 'Cancel',
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

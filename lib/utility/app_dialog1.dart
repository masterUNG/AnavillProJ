// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharetraveyard/utility/app_constant.dart';
import 'package:sharetraveyard/widgets/widget_buttom.dart';
import 'package:sharetraveyard/widgets/widget_text.dart';

class AppDialog1 {
  final BuildContext context;
  AppDialog1({
    required this.context,
  });

  void normalDialog({
    required String title,
    required String subTitle,
    Widget? aactionWidget,
    Widget? ooneActionWidget,
    Widget? aaction2Widget,
    Widget? ccontenWidget,
  }) {
    Get.dialog(
      AlertDialog(
        icon: Icon(
          Icons.dangerous,
          color: AppConstant.active,
          size: 70,
        ),
        title: WidgetText(
          text: title,
          textStyle: AppConstant().h2Style(),
        ),
        content: ccontenWidget ?? WidgetText(text: subTitle),
        actions: [
          aactionWidget ?? const SizedBox(),
          aaction2Widget ?? const SizedBox(),
          ooneActionWidget ??
              Column(
                children: [
                  WidgetButtom(
                    label: aaction2Widget == null ? 'OK' : 'Cancel',
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

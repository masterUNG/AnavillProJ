// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharetraveyard/utility/app_constant.dart';
import 'package:sharetraveyard/widgets/widget_buttom.dart';
import 'package:sharetraveyard/widgets/widget_text.dart';

class AppDialogBuy {
  final BuildContext context;
  AppDialogBuy({
    required this.context,
  });

  void normalDialog({
    required String title,
    required String subTitle,
    Widget? actionWidgetbuy,
    Widget? oneActionWidgetbuy,
    Widget? action2Widgetbuy,
    Widget? contenWidgetbuy,
  }) {
    Get.dialog(
      AlertDialog(
        icon: Icon(
          Icons.shopping_basket,
          color: AppConstant.active1,
          size: 70,
        ),
        title: WidgetText(
          text: title,
          textStyle: AppConstant().h2Style(),
        ),
        content: contenWidgetbuy ?? WidgetText(text: subTitle),
        actions: [
          actionWidgetbuy ?? const SizedBox(),
          action2Widgetbuy ?? const SizedBox(),
          oneActionWidgetbuy ??
              Column(
                children: [
                  WidgetButtom(
                    label: action2Widgetbuy == null ? 'OK' : 'Cancel',
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

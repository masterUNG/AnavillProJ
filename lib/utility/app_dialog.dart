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

  void normalDialog({required String title, required String subTitle}) {
    Get.dialog(
      AlertDialog(
        title: ListTile(
          leading: Icon(
            Icons.dangerous,
            color: AppConstant.active,size: 72,
          ),
          title: WidgetText(
            text: title,
            textStyle: AppConstant().h2Style(),
          ),
          subtitle: WidgetText(text: subTitle),
        ),
        actions: [
          WidgetButtom(
            label: 'OK',
            pressFunc: () => Get.back(),
          )
        ],
      ),
    );
  }
}

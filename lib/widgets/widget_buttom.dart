// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:sharetraveyard/utility/app_constant.dart';
import 'package:sharetraveyard/widgets/widget_text.dart';

class WidgetButtom extends StatelessWidget {
  const WidgetButtom({
    Key? key,
    required this.label,
    required this.pressFunc,
    this.size, 
  }) : super(key: key);

  final String label;
  final Function() pressFunc;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: AppConstant.active),
          onPressed: pressFunc,
          child: WidgetText(
            text: label,
            textStyle: AppConstant().h3Style(color: AppConstant.fieldColor, size: 10),
          )),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sharetraveyard/utility/app_constant.dart';
import 'package:sharetraveyard/widgets/widget_text.dart';

class WidgetTextButtom extends StatelessWidget {
  const WidgetTextButtom({
    Key? key,
    required this.label,
    required this.pressFunc, required MainAxisAlignment ainAxisAlignment,
  }) : super(key: key);

  final String label;
  final Function() pressFunc;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: pressFunc,
        child: WidgetText(
          text: label,
          textStyle:
              AppConstant().h2Style(textDecoration: TextDecoration.underline),
        ));
  }
}

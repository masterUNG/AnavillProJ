import 'package:flutter/material.dart';
import 'package:sharetraveyard/bodys/shop_body.dart';
import 'package:sharetraveyard/states/main_home.dart';
import 'package:sharetraveyard/utility/app_constant.dart';
import 'package:sharetraveyard/widgets/widget_text.dart';
import 'package:sharetraveyard/widgets/widget_text_buttom.dart';
import 'package:sharetraveyard/utility/app_controller.dart';
import 'package:get/get.dart';
class SelectRound extends StatefulWidget {
  const SelectRound({super.key});

  @override
  State<SelectRound> createState() => _SelectRoundState();
}

class _SelectRoundState extends State<SelectRound> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.bgColor,
      body: Container(
        margin: const EdgeInsets.only(left: 50, right: 50, top: 50, bottom: 30),
        child: Column(
          children: [
            Center(
              child: WidgetText(
                text: 'Select Round',
                textStyle: AppConstant().h2Style(),
              ),
            ),
            Row(
              children: [
                WidgetTextButtom(
                  label: '1. IT ELO Device/BKK-JUN01',
                  pressFunc: () {
                    Get.to(MainHome());
                  },
                )
              ],
            ),
            Row(
              children: [
                WidgetTextButtom(
                  label: '2. Staff Sale/P-JUN01',
                  pressFunc: (
                    
                  ) {},
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

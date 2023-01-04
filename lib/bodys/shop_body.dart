import 'package:flutter/material.dart';
import 'package:sharetraveyard/utility/app_constant.dart';
import 'package:sharetraveyard/utility/app_controller.dart';
import 'package:sharetraveyard/widgets/widget_text.dart';

class ShopBody extends StatefulWidget {
  const ShopBody({super.key});

  @override
  State<ShopBody> createState() => _ShopBodyState();
}

class _ShopBodyState extends State<ShopBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 16, bottom: 16),
        child: Column(
          children: [
            Center(
              child: WidgetText(
                text: 'Staff sale',
                textStyle: AppConstant().h2Style(),
              ),
            ),



            Column(
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 16, bottom: 16),
                  child: WidgetText(text: 'Picture'),
                ),
              ],
            ),



            
          ],
        ),
      ),
    );
  }
}

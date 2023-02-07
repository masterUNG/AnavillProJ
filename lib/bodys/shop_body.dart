import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharetraveyard/states/detail_product.dart';
import 'package:sharetraveyard/utility/app_controller.dart';
import 'package:sharetraveyard/utility/app_svervice.dart';
import 'package:sharetraveyard/widgets/widget_text.dart';
import 'package:sharetraveyard/widgets/wigget_image_network.dart';

class ShopBody extends StatefulWidget {
  const ShopBody({super.key});

  @override
  State<ShopBody> createState() => _ShopBodyState();
}

class _ShopBodyState extends State<ShopBody> {
  @override
  void initState() {
    super.initState();
    AppSvervice().readPhotoPD1();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX(
          init: AppController(),
          builder: (AppController appController) {
            print(
                "##7feb iphoneModels ----> ${appController.iphoneModels.length}");
            return appController.iphoneModels.isEmpty
                ? const SizedBox()
                : GridView.builder(
                    itemCount: appController.iphoneModels.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      // mainAxisExtent: 4,
                      // crossAxisSpacing: 4,
                    ),
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Get.to(DetailProduct(
                          iphoneModel: appController.iphoneModels[index],
                          docIdPhotoPd1: appController.docIdPhotopd1s[index],
                        ));
                      },
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            WidgetImageNetwork(
                                urlImage:
                                    appController.iphoneModels[index].cover),
                            WidgetText(
                                text: appController.iphoneModels[index].Name),
                          ],
                        ),
                      ),
                    ),
                  );
          }),
    );
  }
}

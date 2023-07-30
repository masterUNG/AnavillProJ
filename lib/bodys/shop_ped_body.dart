import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharetraveyard/states/detail_ped.dart';
import 'package:sharetraveyard/utility/app_controller.dart';
import 'package:sharetraveyard/utility/app_svervice.dart';
import 'package:sharetraveyard/widgets/widget_text.dart';
import 'package:sharetraveyard/widgets/wigget_image_network.dart';

class ShopPedBody extends StatefulWidget {
  const ShopPedBody({super.key});

  @override
  State<ShopPedBody> createState() => _ShopPedBodyState();
}

class _ShopPedBodyState extends State<ShopPedBody> {
  AppController appController = Get.put(AppController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppSvervice().findProductPed();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return appController.pedmodels.isEmpty
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  itemCount: appController.pedmodels.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      childAspectRatio: 4 / 5,
                      crossAxisCount: 2),
                  itemBuilder: ((context, index) => InkWell(
                        onTap: () {
                          Get.to(DetailPed(
                              pedModel: appController.pedmodels[index],
                              docIdPed: appController.docIdPeds[index],
                              collectionPed: appController.collectionPeds.last));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              WidgetImageNetwork(
                                urlImage:
                                    appController.pedmodels[index].coverped,
                                width: 120,
                                height: 150,
                              ),
                              WidgetText(
                                  text: appController.pedmodels[index].model),
                            ],
                          ),
                        ),
                      ))),
            );
    });
  }
}

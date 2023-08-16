import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharetraveyard/models/ped_model.dart';
import 'package:sharetraveyard/states/detail_ped.dart';
import 'package:sharetraveyard/states/payment_upload_ped.dart';
import 'package:sharetraveyard/utility/app_controller.dart';
import 'package:sharetraveyard/utility/app_dialog.dart';
import 'package:sharetraveyard/utility/app_svervice.dart';
import 'package:sharetraveyard/widgets/widget_buttom.dart';
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
                        onTap: () async {
                          if (appController.reservePeds[index]) {
                            //จองอยู่
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            var user = preferences.getString('user');

                            for (var element
                                in appController.pedmodels[index].maps!) {
                              if (element['associateID'] == user) {
                                
                              }
                            }

                            dialogConfrimBuy(context,
                                pedModel: appController.pedmodels[index],
                                amount: appController.amountPed.value,
                               
                                docIdPed: appController.docIdPeds[index]);
                          } else {
                            Get.to(DetailPed(
                                    pedModel: appController.pedmodels[index],
                                    docIdPed: appController.docIdPeds[index],
                                    collectionPed:
                                        appController.collectionPeds.last))!
                                .then((value) {
                                    AppSvervice().findProductPed();
                                });
                          }
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
                              appController.reservePeds[index]
                                  ? Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration:
                                          BoxDecoration(color: Colors.yellow),
                                      child: WidgetText(text: 'Reserve'),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      ))),
            );
    });
  }

  void dialogConfrimBuy(BuildContext context,
      {required PedModel pedModel,
      required amount,
      required String docIdPed}) {
    AppDialog(context: context).normalDialog(
        title: 'Buy Sure ?',
        subTitle:
            'คุณต้องโอนเงินจำนวน\n $amount x ${pedModel.price} = ${amount * int.parse(pedModel!.price)} บาท\n ไปที่ ธนาคาร และ upload slip',
        action2Widget: WidgetButtom(
          label: 'upload Slip',
          pressFunc: () {
            Get.back();
            Get.to(PaymentUploadPed(
                pedModel: pedModel,
                docIdPed: docIdPed,
                collectionPed: appController.collectionPeds.last));
          },
        ));
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sharetraveyard/models/iphone_model.dart';
import 'package:sharetraveyard/states/payment_upload.dart';
import 'package:sharetraveyard/utility/app_constant.dart';
import 'package:sharetraveyard/utility/app_dialog.dart';
import 'package:sharetraveyard/widgets/widget_buttom.dart';
import 'package:sharetraveyard/widgets/widget_text.dart';
import 'package:sharetraveyard/widgets/wigget_image_network.dart';

class DetailProduct extends StatelessWidget {
  const DetailProduct({
    Key? key,
    required this.iphoneModel,
    required this.docIdPhotoPd1,
  }) : super(key: key);

  final IphoneModel iphoneModel;
  final String docIdPhotoPd1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: WidgetText(
          text: iphoneModel.Name,
          textStyle: AppConstant().h2Style(),
        ),
      ),
      body: Column(
        children: [
          WidgetImageNetwork(urlImage: iphoneModel.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: WidgetText(text: 'Price'),
                ),
                Expanded(
                  flex: 2,
                  child: WidgetText(
                    text: iphoneModel.price.toString(),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: WidgetText(text: 'Stock'),
                ),
                Expanded(
                  flex: 2,
                  child: WidgetText(
                    text: iphoneModel.stock.toString(),
                  ),
                ),
              ],
            ),
          ),
          WidgetButtom(
            label: 'Buy',
            pressFunc: () {
              AppDialog(context: context).normalDialog(
                  title: 'Buy Sure ?',
                  subTitle:
                      'คุณต้องโอนเงินจำนวน ${iphoneModel.price} บาท ไปที่ ธนาคาร 419-2323-2323 และ upload slip',
                  actionWidget: WidgetButtom(
                    label: 'upload Slip',
                    pressFunc: () {
                      Get.back();
                      Get.to(
                        PaymentUpload(
                          iphoneModel: iphoneModel, docIdPhotoPd1: docIdPhotoPd1,
                        ),
                      );
                    },
                  ));
            },
          )
        ],
      ),
    );
  }
}

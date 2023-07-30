// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharetraveyard/models/iphone_model.dart';

import 'package:sharetraveyard/models/order_model.dart';
import 'package:sharetraveyard/utility/app_controller.dart';
import 'package:sharetraveyard/utility/app_svervice.dart';
import 'package:sharetraveyard/widgets/widget_text.dart';
import 'package:sharetraveyard/widgets/wigget_image_network.dart';

class DisplayOrderDetail extends StatefulWidget {
  const DisplayOrderDetail({
    Key? key,
    required this.orderModel,
    required this.nameProdcut,
  }) : super(key: key);

  final OderModel orderModel;
  final String nameProdcut;

  @override
  State<DisplayOrderDetail> createState() => _DisplayOrderDetailState();
}

class _DisplayOrderDetailState extends State<DisplayOrderDetail> {
  AppController appController = Get.put(AppController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    processFindIPhoneModel();
  }

  Future<void> processFindIPhoneModel() async {
    if (widget.orderModel.docPhotopd1.isNotEmpty) {
      if (appController.detailIphones.isNotEmpty) {
        appController.detailIphones.clear();
      }
      IphoneModel iphoneModel = await AppSvervice().findphotodp1ModelWhareDocId(
          docIdPhoto1: widget.orderModel.docPhotopd1,
          collectionProduct: widget.orderModel.collectionProduct!);
      appController.detailIphones.add(iphoneModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: WidgetText(
          text: 'Detail ${widget.nameProdcut}',
        ),
      ),
      body: widget.orderModel.docPhotopd1.isEmpty
          ? ListView(
              children: [
                WidgetText(text: 'For Ped'),
                WidgetImageNetwork(
                  urlImage: widget.orderModel.mapPed!['coverped'],
                  width: double.infinity,
                ),
                WidgetText(text: widget.orderModel.mapPed!['model']),
                WidgetText(text: widget.orderModel.mapPed!['pedID']),
              ],
            )
          : Obx(() {
              return appController.detailIphones.isEmpty
                  ? const SizedBox()
                  : ListView(
                    children: [
                      WidgetText(text: 'For Mobile'),
                      WidgetImageNetwork(urlImage: appController.detailIphones.last.cover,width: double.infinity,),
                      WidgetText(text: appController.detailIphones.last.model),
                      WidgetText(text: appController.detailIphones.last.price.toString()),
                    ],
                  );
            }),
    );
  }
}

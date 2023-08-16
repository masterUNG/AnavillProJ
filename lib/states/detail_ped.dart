// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sharetraveyard/models/iphone_model.dart';
import 'package:sharetraveyard/models/ped_model.dart';
import 'package:sharetraveyard/states/payment_upload.dart';
import 'package:sharetraveyard/states/payment_upload_ped.dart';
import 'package:sharetraveyard/utility/app_constant.dart';
import 'package:sharetraveyard/utility/app_controller.dart';
import 'package:sharetraveyard/utility/app_dialog.dart';
import 'package:sharetraveyard/widgets/widget_buttom.dart';
import 'package:sharetraveyard/widgets/widget_icon_buttom.dart';
import 'package:sharetraveyard/widgets/widget_text.dart';
import 'package:sharetraveyard/widgets/wigget_image_network.dart';

class DetailPed extends StatefulWidget {
  const DetailPed({
    Key? key,
    required this.pedModel,
    required this.docIdPed,
    required this.collectionPed,
  }) : super(key: key);

  final PedModel pedModel;
  final String docIdPed;
  final String collectionPed;

  @override
  State<DetailPed> createState() => _DetailPedState();
}

class _DetailPedState extends State<DetailPed> {
  PedModel? pedModel;
  AppController appController = Get.put(AppController());
  int amountStock = 0;

  @override
  void initState() {
    super.initState();
    pedModel = widget.pedModel;
    findCurrentStock();
  }

  void findCurrentStock() {
    int amountReserve = 0;
    if (pedModel!.maps!.isNotEmpty) {
      for (var element in pedModel!.maps!) {
        //
        DateTime dateTimeReserve = element['timestamp'].toDate();
        //ปรับเวลาตรงนี้
        dateTimeReserve = dateTimeReserve.add(Duration(minutes: 3));

        if (dateTimeReserve.difference(DateTime.now()).inMinutes > 0) {
          int amount = element['amount'];
          amountReserve = amountReserve + amount;
        }
      }
      print('amountReserve --->$amountReserve');
      amountStock = int.parse(pedModel!.stock) - amountReserve;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: WidgetText(
          text: pedModel!.model,
          textStyle: AppConstant().h2Style(),
        ),
      ),
      body: ListView(
        children: [
          Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: AppConstant().borderCurveBox(),
              child: WidgetImageNetwork(urlImage: pedModel!.coverped)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: WidgetText(text: 'pedID'),
                ),
                Expanded(
                  flex: 2,
                  child: WidgetText(
                    text: pedModel!.pedID,
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
                  child: WidgetText(text: 'price'),
                ),
                Expanded(
                  flex: 2,
                  child: WidgetText(
                    text: pedModel!.price,
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
                  child: WidgetText(text: 'stock'),
                ),
                Expanded(
                  flex: 2,
                  child: WidgetText(
                    text: amountStock.toString(),
                  ),
                ),
              ],
            ),
          ),
          pedModel!.timestamp == Timestamp(0, 0)
              ? BuyButtom(context)
              : pedModel!.timestamp
                          .toDate()
                          .difference(DateTime.now())
                          .inMinutes <
                      //inMinutes ปรับเวลาตรงนี้ และ ตรง file shop bodys line 163
                      -1
                  ? BuyButtom(context)
                  : InkWell(
                      onTap: () async {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        String? associate = preferences.getString('user');
                        //เมื่อมีการกดจะเปลี่น associte ใหม่ทักครั้ง

                        if (associate == pedModel!.associate) {
                          //can buy
                          productBuy(context);
                        } else {
                          AppDialog(context: context).normalDialog(
                              title: 'Cannot Buy',
                              subTitle:
                                  'This Product Revere Please Wet , Or Choose Othre');
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(color: Colors.yellow),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: WidgetText(
                            text: 'Pending Payment',
                            textStyle: AppConstant().h2Style(),
                          ),
                        ),
                      ),
                    ),
        ],
      ),
    );
  }

  Widget BuyButtom(BuildContext context) {
    return amountStock == 0
        ? WidgetText(
            text: 'Sale Out',
            textStyle: AppConstant().h3Style(
              color: Colors.red,
            ),
          )
        : WidgetButtom(
            label: 'Reserve or Buy',
            pressFunc: () {
              appController.amountPed.value = 1;
              productBuy(context);
            },
          );
  }

  void productBuy(BuildContext context) {
    AppDialog(context: context).normalDialog(
      title: 'Reserve or Buy',
      subTitle: 'Please Recerve or buy',
      contenWidget: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          WidgetIconButtom(
            iconData: Icons.remove_circle,
            pressFunc: () {
              if (appController.amountPed > 1) {
                appController.amountPed--;
              }
            },
          ),
          Obx(() {
            return WidgetText(text: appController.amountPed.value.toString());
          }),
          WidgetIconButtom(
            iconData: Icons.add_circle,
            pressFunc: () {
              if (appController.amountPed < int.parse(pedModel!.stock)) {
                appController.amountPed++;
              }
            },
          )
        ],
      ),
      // actionWidget: WidgetButtom(
      //   label: 'Reserve',
      //   pressFunc: () async {
      //     SharedPreferences preferences = await SharedPreferences.getInstance();
      //     String? associate = preferences.getString('user');

      //     Map<String, dynamic> map = pedModel!.toMap();
      //     map['timestamp'] = Timestamp.fromDate(DateTime.now());
      //     map['associate'] = associate!;

      //     FirebaseFirestore.instance
      //         .collection(widget.collectionPed)
      //         .doc(widget.docIdPed)
      //         .update(map)
      //         .then((value) {
      //       Get.back();
      //       pedModel = PedModel.fromMap(map);
      //       setState(() {});
      //     });
      //   },
      // ),

      actionWidget: WidgetButtom(
        label: 'Reserve',
        pressFunc: () async {
          SharedPreferences preferences = await SharedPreferences.getInstance();

          Map<String, dynamic> map = {};
          map['amount'] = appController.amountPed.value;
          map['associateID'] = preferences.getString('user');
          map['timestamp'] = Timestamp.fromDate(DateTime.now());
          print('##16aug map----->$map');

          Map<String, dynamic> mapPedModel = widget.pedModel.toMap();
          print('mapPedmodel before ---> $mapPedModel');

          var maps = <Map<String, dynamic>>[];
          if (mapPedModel['maps'].isNotEmpty) {
            for (var element in mapPedModel['maps']) {
              maps.add(element);
            }
          }
          print('maps before ---->$maps');

          maps.add(map);

          print('maps after ---->$maps');

          mapPedModel['maps'] = maps;

          print('mapPedmodel after ---> $mapPedModel');

          FirebaseFirestore.instance
              .collection(widget.collectionPed)
              .doc(widget.docIdPed)
              .update(mapPedModel)
              .then((value) {
            print('update Success');
            Get.back();
            Get.back();
          });
        },
      ),
      action2Widget: WidgetButtom(
        label: 'Buy',
        pressFunc: () {
          Get.back();
          dialogConfrimBuy(context);
        },
      ),
    );
  }

  void dialogConfrimBuy(BuildContext context) {
    AppDialog(context: context).normalDialog(
        title: 'Buy Sure ?',
        subTitle:
            'คุณต้องโอนเงินจำนวน\n ${appController.amountPed.value}x ${pedModel!.price} = ${appController.amountPed.value * int.parse(pedModel!.price)} บาท\n ไปที่ ธนาคาร และ upload slip',
        action2Widget: WidgetButtom(
          label: 'upload Slip',
          pressFunc: () {
            Get.back();
            Get.to(PaymentUploadPed(
                pedModel: widget.pedModel,
                docIdPed: widget.docIdPed,
                collectionPed: widget.collectionPed));
          },
        ));
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sharetraveyard/models/iphone_model.dart';
import 'package:sharetraveyard/states/payment_upload.dart';
import 'package:sharetraveyard/utility/app_constant.dart';
import 'package:sharetraveyard/utility/app_dialog.dart';
import 'package:sharetraveyard/widgets/widget_buttom.dart';
import 'package:sharetraveyard/widgets/widget_text.dart';
import 'package:sharetraveyard/widgets/wigget_image_network.dart';

class DetailProduct extends StatefulWidget {
  const DetailProduct({
    Key? key,
    required this.iphoneModel,
    required this.docIdPhotoPd1,
    required this.collectionProduct,
  }) : super(key: key);

  final IphoneModel iphoneModel;
  final String docIdPhotoPd1;
  final String collectionProduct;

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  IphoneModel? iphoneModel;

  @override
  void initState() {
    super.initState();
    iphoneModel = widget.iphoneModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: WidgetText(
          text: widget.iphoneModel.model,
          textStyle: AppConstant().h2Style(),
        ),
      ),
      body: Column(
        children: [
          Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: AppConstant().borderCurveBox(),
              child: WidgetImageNetwork(urlImage: widget.iphoneModel.cover)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: WidgetText(text: 'SeriaID'),
                ),
                Expanded(
                  flex: 2,
                  child: WidgetText(
                    text: widget.iphoneModel.serialID.toString(),
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
                  child: WidgetText(text: 'Capacity'),
                ),
                Expanded(
                  flex: 2,
                  child: WidgetText(
                    text: widget.iphoneModel.capacity.toString(),
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
                  child: WidgetText(text: 'Grade'),
                ),
                Expanded(
                  flex: 2,
                  child: WidgetText(
                    text: widget.iphoneModel.grade.toString(),
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
                  child: WidgetText(text: 'Price'),
                ),
                Expanded(
                  flex: 2,
                  child: WidgetText(
                    text: widget.iphoneModel.price.toString(),
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
                    text: widget.iphoneModel.stock.toString(),
                  ),
                ),
              ],
            ),
          ),
          iphoneModel!.timestamp == Timestamp(0, 0)
              ? BuyButtom(context)
              : iphoneModel!.timestamp!
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

                        if (associate == iphoneModel!.associate) {
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

  WidgetButtom BuyButtom(BuildContext context) {
    return WidgetButtom(
      label: 'Reserve or Buy',
      pressFunc: () {
        productBuy(context);
      },
    );
  }

  void productBuy(BuildContext context) {
    AppDialog(context: context).normalDialog(
      title: 'Reserve or Buy',
      subTitle: 'Please Recerve or buy',
      actionWidget: WidgetButtom(
        label: 'Reserve',
        pressFunc: () async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          String? associate = preferences.getString('user');

          Map<String, dynamic> map = iphoneModel!.toMap();
          map['timestamp'] = Timestamp.fromDate(DateTime.now());
          map['associate'] = associate!;

          FirebaseFirestore.instance
              .collection(widget.collectionProduct)
              .doc(widget.docIdPhotoPd1)
              .update(map)
              .then((value) {
            Get.back();
            iphoneModel = IphoneModel.fromMap(map);
            setState(() {});
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
            'คุณต้องโอนเงินจำนวน ${widget.iphoneModel.price} บาท ไปที่ ธนาคาร และ upload slip',
        actionWidget: WidgetButtom(
          label: 'upload Slip',
          pressFunc: () {
            Get.back();
            Get.to(
              PaymentUpload(
                iphoneModel: widget.iphoneModel,
                docIdPhotoPd1: widget.docIdPhotoPd1,
                collectionProduct: widget.collectionProduct,
              ),
            );
          },
        ));
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sharetraveyard/models/associate_model.dart';
import 'package:sharetraveyard/models/iphone_model.dart';
import 'package:sharetraveyard/models/order_model.dart';
import 'package:sharetraveyard/models/ped_model.dart';
import 'package:sharetraveyard/states/select_site.dart';
import 'package:sharetraveyard/utility/app_constant.dart';
import 'package:sharetraveyard/utility/app_controller.dart';
import 'package:sharetraveyard/widgets/widget_buttom.dart';
import 'package:sharetraveyard/widgets/widget_storage_service.dart';
import 'package:sharetraveyard/widgets/widget_text.dart';
import 'package:sharetraveyard/widgets/wigget_image_network.dart';

class PaymentUploadPed extends StatefulWidget {
  const PaymentUploadPed({
    Key? key,
    required this.pedModel,
    required this.docIdPed,
    required this.collectionPed,
  }) : super(key: key);
  final PedModel pedModel;
  final String docIdPed;
  final String collectionPed;

  @override
  State<PaymentUploadPed> createState() => _PaymentUploadPedState();
}

class _PaymentUploadPedState extends State<PaymentUploadPed> {
  String? urlGetOR;
  File? image;

  AsscociateModel? asscociateModel;

  @override
  void initState() {
    super.initState();
    findAssociateModel();
  }

  Future<void> findAssociateModel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? associate = preferences.getString('user');

    var result = await FirebaseFirestore.instance
        .collection('associate')
        .doc(associate)
        .get();
    asscociateModel = AsscociateModel.fromMap(result.data()!);
  }

  Future<void> picker() async {
    try {
      final XFile? pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return;

      final imageTemporary = File(pickedImage.path);
      setState(() {
        image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Scaffold(
      backgroundColor: AppConstant.bgColor,
      body: GetX(
        init: AppController(),
        builder: (AppController appController) {
          print('##7feb urlImage -----> ${appController.urlImage.length}');
          return Container(
            margin:
                const EdgeInsets.only(left: 50, right: 50, top: 60, bottom: 30),
            child: ListView(
              children: [
                Center(
                  child: WidgetText(
                    text: 'Payment',
                    textStyle: AppConstant().h4Style(),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      WidgetText(
                        text: 'บัญชี : บริษัท มาร์ส เพ็ทแคร์',
                        textStyle: AppConstant().h2Style(),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Center(
                        child: WidgetText(
                          text: 'SCB : 622-2-46005-8',
                          textStyle: AppConstant().h2Style(),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Center(
                        child: WidgetText(
                          text:
                              'Total amount to be price : ${widget.pedModel.price}',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),

                WidgetImageNetwork(urlImage: AppConstant.urlPromPay),

                const SizedBox(
                  height: 32,
                ),

                Container(
                  child: Column(
                    children: [
                      WidgetButtom(
                        label: 'Upload Payment',
                        pressFunc: () async {
                          var result = await ImagePicker().pickImage(
                              source: ImageSource.gallery,
                              maxWidth: 800,
                              maxHeight: 800);

                          File file = File(result!.path);

                          final path = result.path;
                          final fileName = basename(file.path);

                          //final path = results.files.single.path!;
                          //final fileName = results.files.single.name;

                          print(path);
                          print(fileName);

                          await storage
                              .uploadFile(
                            path,
                            fileName,
                          )
                              .then((_) async {
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            String? docIdAssociate =
                                preferences.getString('user');

                            OderModel oderModel = OderModel(
                              docIdAssociate: docIdAssociate!,
                              docPhotopd1: '',
                              urlSlip: appController.urlImage.last,
                              salseFinish: false,
                              collectionProduct: widget.collectionPed,
                              timestamp: Timestamp.fromDate(DateTime.now()),
                              price: widget.pedModel.price.toString(),
                              nameAssociate: asscociateModel!.name,
                              itemName: widget.pedModel.model,
                              roundID: appController.periodModels.last.roundID,
                              roundStatus:
                                  appController.periodModels.last.saleday,
                              branch: appController.displaySiteCode.value,
                              periodsale:
                                  appController.periodModels.last.periodsale,
                              docIdPed: widget.docIdPed,
                              mapPed: widget.pedModel.toMap(),
                            );

                            print('##8feb OderModel ---> ${oderModel.toMap()}');

                            var reference = FirebaseFirestore.instance
                                .collection('order')
                                .doc();

                            await reference
                                .set(oderModel.toMap())
                                .then((_) async {
                              String docIdOrder = reference.id;
                              print(
                                  '##8feb success docIdOrder --> $docIdOrder');

                              urlGetOR =
                                  'https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=$docIdOrder';

                              // IphoneModel iphoneModel = widget.iphoneModel;
                              PedModel pedModel = widget.pedModel;

                              var map = pedModel.toMap();
                              map['reserve'] = true;

                              int stockInt = int.parse(pedModel.stock)- appController.amountPed.value;


                              map['stock'] = stockInt.toString();
                              pedModel = PedModel.fromMap(map);

                              await FirebaseFirestore.instance
                                  .collection(widget.collectionPed)
                                  .doc(widget.docIdPed)
                                  .update(pedModel.toMap())
                                  .then((_) {
                                print(
                                    '##18mar controller.displaySiteCode.value ----> ${appController.displaySiteCode.value}');
                                Get.offAll(const SelectSite(
                                  assoiate: '',
                                ));
                              });
                            });
                          });

                          setState(() {
                            image =
                                null; // Reset the image variable after uploading
                          });
                        },
                      ),
                    ],
                  ),
                ),
                // urlGetOR == null
                //     ? const SizedBox()
                //     : WidgetImageNetwork(urlImage: urlGetOR!),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:image_picker_web/image_picker_web.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharetraveyard/models/associate_model.dart';
import 'package:sharetraveyard/models/iphone_model.dart';
import 'package:sharetraveyard/models/order_model.dart';
import 'package:sharetraveyard/states/select_site.dart';
import 'package:sharetraveyard/utility/app_constant.dart';
import 'package:sharetraveyard/utility/app_controller.dart';
import 'package:sharetraveyard/utility/app_dialog.dart';
import 'package:sharetraveyard/widgets/widget_buttom.dart';
import 'package:sharetraveyard/widgets/widget_storage_service.dart';
import 'package:sharetraveyard/widgets/widget_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:sharetraveyard/widgets/wigget_image_network.dart';

class PaymentUploadWeb extends StatefulWidget {
  const PaymentUploadWeb({
    Key? key,
    required this.iphoneModel,
    required this.docIdPhotoPd1,
    required this.collectionProduct,
  }) : super(key: key);
  final IphoneModel iphoneModel;
  final String docIdPhotoPd1;
  final String collectionProduct;

  @override
  State<PaymentUploadWeb> createState() => _PaymentUploadWebState();
}

class _PaymentUploadWebState extends State<PaymentUploadWeb> {
  String? urlGetOR;
  File? image;

  AsscociateModel? asscociateModel;

  AppController controller = Get.put(AppController());

  @override
  void initState() {
    super.initState();
    findAssociateModel();
  }

  Future<void> findAssociateModel() async {
    String? associate = controller.currentAssociateLogin.last.associateID;

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
                              'Total amount to be price : ${widget.iphoneModel.price}',
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
                          try {
                            // var result = await ImagePicker.getImageAsBytes();

                            var result = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);

                            var imageByte = await result!.readAsBytes();

                            String path =
                                'payment_upload/payment${Random().nextInt(1000000)}.jpg';

                            FirebaseStorage firebaseStorage =
                                FirebaseStorage.instance;

                            Reference reference =
                                firebaseStorage.ref().child(path);

                            UploadTask uploadTask = reference.putData(imageByte!,
                                SettableMetadata(contentType: 'image/jpeg'));
                            await uploadTask.whenComplete(() async {
                              await reference
                                  .getDownloadURL()
                                  .then((value) async {
                                String urlImage = value;
                                print('##21nov urlImage ----> $urlImage');

                                String? docIdAssociate = controller
                                    .currentAssociateLogin.last.associateID;

                                OderModel oderModel = OderModel(
                                  docIdAssociate: docIdAssociate!,
                                  docPhotopd1: widget.docIdPhotoPd1,
                                  urlSlip: urlImage,
                                  salseFinish: false,
                                  collectionProduct: widget.collectionProduct,
                                  timestamp: Timestamp.fromDate(DateTime.now()),
                                  price: widget.iphoneModel.price.toString(),
                                  nameAssociate: asscociateModel!.name,
                                  itemName: widget.iphoneModel.model,
                                  roundID:
                                      appController.periodModels.last.roundID,
                                  roundStatus:
                                      appController.periodModels.last.saleday,
                                  branch: appController.displaySiteCode.value,
                                  periodsale: appController
                                      .periodModels.last.periodsale,
                                  statusRound: appController
                                          .periodModels.last.statusRound!
                                      ? 'Owner'
                                      : 'General',
                                );

                                print(
                                    '##8feb OderModel ---> ${oderModel.toMap()}');

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

                                  IphoneModel iphoneModel = widget.iphoneModel;
                                  print(
                                      '##18mar before saleFinish -----> ${iphoneModel.salseFinish}');

                                  var map = iphoneModel.toMap();
                                  map['reserve'] = true;
                                  iphoneModel = IphoneModel.fromMap(map);

                                  print(
                                      '##18mar after saleFinish -----> ${iphoneModel.salseFinish}');
                                  await FirebaseFirestore.instance
                                      .collection(widget.collectionProduct)
                                      .doc(widget.docIdPhotoPd1)
                                      .update(iphoneModel.toMap())
                                      .then((_) {
                                    print('##22oct upload slip success');

                                    AppDialog(context: context).normalDialog(
                                        title: 'Upload Finish',
                                        subTitle: 'ThangYou',
                                        oneActionWidget: WidgetButtom(
                                          label: 'OK',
                                          pressFunc: () {
                                            Get.offAll(const SelectSite(
                                              assoiate: '',
                                            ));
                                          },
                                        ));
                                  });
                                });
                              });
                            });
                          } on Exception catch (e) {
                            Get.snackbar('Cannot Upload', 'Please Try Again');
                          }

                          //end

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

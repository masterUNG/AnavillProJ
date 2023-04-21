// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharetraveyard/models/iphone_model.dart';
import 'package:sharetraveyard/models/order_model.dart';
import 'package:sharetraveyard/states/select_site.dart';
import 'package:sharetraveyard/utility/app_constant.dart';
import 'package:sharetraveyard/utility/app_controller.dart';
import 'package:sharetraveyard/widgets/widget_buttom.dart';
import 'package:sharetraveyard/widgets/widget_storage_service.dart';
import 'package:sharetraveyard/widgets/widget_text.dart';


class PaymentUpload extends StatefulWidget {
  const PaymentUpload({
    Key? key,
    required this.iphoneModel,
    required this.docIdPhotoPd1,
    required this.collectionProduct,
  }) : super(key: key);
  final IphoneModel iphoneModel;
  final String docIdPhotoPd1;
  final String collectionProduct;

  @override
  State<PaymentUpload> createState() => _PaymentUploadState();
}

class _PaymentUploadState extends State<PaymentUpload> {
  String? urlGetOR;

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
              margin: const EdgeInsets.only(
                  left: 50, right: 50, top: 60, bottom: 30),
              child: Column(
                children: [
                  Center(
                    child: WidgetText(
                      text: 'Payment',
                      textStyle: AppConstant().h2Style(),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: Column(
                      children: [
                        Center(
                          child: WidgetText(
                              text: 'Plase Transfer to SCB : 4194821427'),
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
                                  'Total amount to be paid :  ${widget.iphoneModel.price}'),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        WidgetButtom(
                          label: 'UploadPayment',
                          pressFunc: () async {
                            final results = await FilePicker.platform.pickFiles(
                              allowMultiple: false,
                              type: FileType.custom,
                              allowedExtensions: ['png', 'jpg'],
                            );
                            if (results == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('No file selecte'),
                                ),
                              );
                            }
                            final path = results!.files.single.path!;
                            final fileName = results!.files.single.name;

                            print(path);
                            print(fileName);

                            storage
                                .uploadFile(path, fileName)
                                .then((value) async {
                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();

                              String? docIdAssociate =
                                  preferences.getString('user');

                              OderModel oderModel = OderModel(
                                  docIdAssociate: docIdAssociate!,
                                  docPhotopd1: widget.docIdPhotoPd1,
                                  urlSlip: appController.urlImage.last,
                                  salseFinish: false,
                                  collectionProduct: widget.collectionProduct,
                                  timestamp: Timestamp.fromDate(DateTime.now()),
                                  price: widget.iphoneModel.price.toString());
                                  

                              print(
                                  '##8feb OderModel ---> ${oderModel.toMap()}');

                              var reference = FirebaseFirestore.instance
                                  .collection('order')
                                  .doc();

                              await reference
                                  .set(oderModel.toMap())
                                  .then((value) async {
                                String docIdOrder = reference.id;
                                print(
                                    '##8feb sucess docIdOder -- > $docIdOrder');

                                urlGetOR =
                                    'https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=$docIdOrder';

                                IphoneModel iphoneModel = widget.iphoneModel;
                                print(
                                    '##18mar befor saleFinsh ----->${iphoneModel.salseFinish}');

                                var map = iphoneModel.toMap();
                                map['reserve'] = true;
                                iphoneModel = IphoneModel.fromMap(map);

                                print(
                                    '##18mar behind saleFinsh ----->${iphoneModel.salseFinish}');
                                await FirebaseFirestore.instance
                                    .collection(widget.collectionProduct)
                                    .doc(widget.docIdPhotoPd1)
                                    .update(iphoneModel.toMap())
                                    .then((value) {
                                  // Get.offAll(MainHome());

                                  print(
                                      '##18mar controller.displaySiteCode.value ---->${appController.displaySiteCode.value}');
                                  Get.offAll(const SelectSite());
                                });

                                // setState(() {});
                              });
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
          }),
    );
  }
}

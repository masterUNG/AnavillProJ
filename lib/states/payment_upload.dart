import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sharetraveyard/utility/app_constant.dart';
import 'package:sharetraveyard/widgets/widget_buttom.dart';
import 'package:sharetraveyard/widgets/widget_storage_service.dart';
import 'package:sharetraveyard/widgets/widget_text.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class PaymentUpload extends StatelessWidget {
  const PaymentUpload({super.key});

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Scaffold(
      backgroundColor: AppConstant.bgColor,
      body: Container(
        margin: const EdgeInsets.only(left: 50, right: 50, top: 60, bottom: 30),
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
                    child:
                        WidgetText(text: 'Plase Transfer to SCB : 4194821427'),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Center(
                    child: WidgetText(text: 'Total amount to be paid :  4000'),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 200),
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
                          .then((value) => print(' ## Done'));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

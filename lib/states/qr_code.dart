import 'package:flutter/material.dart';
import 'package:sharetraveyard/utility/app_constant.dart';
import 'package:sharetraveyard/widgets/widget_text.dart';
import 'package:upi_payment_qrcode_generator/upi_payment_qrcode_generator.dart';

class QrCode extends StatefulWidget {
  const QrCode({super.key});

  @override
  State<QrCode> createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  final upiDetails = UPIDetails(
      upiID: "UPI ID Here eg. 73641234@paytm",
      payeeName: "input",
      amount: 1,
      transactionNote: "Hello World");
  final upiDetailsWithoutAmount = UPIDetails(
      upiID: "UPI ID Here eg. 73641234@paytm",
      payeeName: "input data ",
      transactionNote: "Hello World");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.bgColor,
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 70),
              child: WidgetText(
                text: 'Notification',
                textStyle: AppConstant().h2Style(),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 80),
                  child: WidgetText(
                    text: 'QRCode',
                    textStyle: AppConstant().h2Style(),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: UPIPaymentQRCode(
                upiDetails: upiDetailsWithoutAmount,
                size: 200,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 25),
              child: WidgetText(
                text: 'Scan QR To Pick UP Product',
                textStyle: AppConstant().h2Style(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

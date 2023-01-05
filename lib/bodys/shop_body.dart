import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sharetraveyard/models/iphone_model.dart';

class ShopBody extends StatefulWidget {
  const ShopBody({super.key});

  @override
  State<ShopBody> createState() => _ShopBodyState();
}

class _ShopBodyState extends State<ShopBody> {
  List<Widget> widgets = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData();
  }

  Future<Null> readData() async {
    await Firebase.initializeApp().then((value) async {
      print('## initialize Successs');
      await FirebaseFirestore.instance
          .collection('photopd1')
          .orderBy('Name')
          .snapshots()
          .listen((event) {
        print('## snapshop = ${event.docs}');
        for (var snapshots in event.docs) {
          Map<String, dynamic> map = snapshots.data();
          print('## map = $map');
          IphoneModel model = IphoneModel.fromMap(map);
          //PhotoModel model = PhotoModel.fromMap(map);
          print(' ## name = ${model.Name}');

          setState(() {
            widgets.add(createWidget(model));
          });
        }
      });
    });
  }

  Widget createWidget(IphoneModel model) => Container(
        width: 100,
        child: Image.network(model.cover),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgets.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.extent(
              maxCrossAxisExtent: 160,
              children: widgets,
            ),
            
    );
  }
}

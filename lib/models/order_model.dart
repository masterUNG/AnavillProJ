// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class OderModel {
  final String docIdAssociate;
  final String nameAssociate;
  final String roundID;
  final String roundStatus;
  final String itemName;
  final String docPhotopd1;
  final String urlSlip;
  final Timestamp timestamp;
  final bool? salseFinish;
  final String? collectionProduct;
  final String price;
  final String branch;
  final String periodsale;
  final String? docIdPed;
  final Map<String, dynamic>? mapPed;
  final int? amountPed;
  final String statusRound;

  OderModel({
    required this.docIdAssociate,
    required this.nameAssociate,
    required this.roundID,
    required this.roundStatus,
    required this.itemName,
    required this.docPhotopd1,
    required this.urlSlip,
    required this.timestamp,
    this.salseFinish,
    this.collectionProduct,
    required this.price,
    required this.branch,
    required this.periodsale,
    this.docIdPed,
    this.mapPed,
    this.amountPed,
    required this.statusRound,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docIdAssociate': docIdAssociate,
      'nameAssociate': nameAssociate,
      'roundID': roundID,
      'roundStatus': roundStatus,
      'itemName': itemName,
      'docPhotopd1': docPhotopd1,
      'urlSlip': urlSlip,
      'timestamp': timestamp,
      'salseFinish': salseFinish,
      'collectionProduct': collectionProduct,
      'price': price,
      'branch': branch,
      'periodsale': periodsale,
      'docIdPed': docIdPed,
      'mapPed': mapPed,
      'amountPed': amountPed,
      'statusRound': statusRound,
    };
  }

  factory OderModel.fromMap(Map<String, dynamic> map) {
    return OderModel(
      docIdAssociate: (map['docIdAssociate'] ?? '') as String,
      nameAssociate: (map['nameAssociate'] ?? '') as String,
      roundID: (map['roundID'] ?? '') as String,
      roundStatus: (map['roundStatus'] ?? '') as String,
      itemName: (map['itemName'] ?? '') as String,
      docPhotopd1: (map['docPhotopd1'] ?? '') as String,
      urlSlip: (map['urlSlip'] ?? '') as String,
      timestamp: map['timestamp'] ?? Timestamp(0, 0),
      salseFinish: map['salseFinish'] ?? false,
      collectionProduct: map['collectionProduct'] ?? '',
      price: (map['price'] ?? '') as String,
      branch: (map['branch'] ?? '') as String,
      periodsale: (map['periodsale'] ?? '') as String,
      docIdPed: (map['docIdPed'] ?? '') as String,
      mapPed: Map<String, dynamic>.from(map['mapPed'] ?? {}),
      amountPed: map['amountPed'] ?? 1,
      statusRound: (map['statusRound'] ?? '') as String,
    );
  }

//  docIdAssociate: (map['docIdAssociate'] ?? '') as String,
//       nameAssociate: (map['nameAssociate'] ?? '') as String,
//       roundID: (map['roundID'] ?? '') as String,
//       roundStatus: (map['roundStatus'] ?? '') as String,
//       itemName: (map['itemName'] ?? '') as String,
//       docPhotopd1: (map['docPhotopd1'] ?? '') as String,
//       urlSlip: (map['urlSlip'] ?? '') as String,
//       timestamp: map['timestamp'] ?? Timestamp(0, 0),
//       salseFinish: map['salseFinish'] ?? false,
//       collectionProduct: map['collectionProduct'] ?? '',
//       price: (map['price'] ?? '') as String,
//       branch: (map['branch'] ?? '') as String,
//       periodsale: (map['periodsale'] ?? '') as String,
//       docIdPed: (map['docIdPed'] ?? '') as String,
//       mapPed: Map<String, dynamic>.from(map['mapPed'] ?? {}),
//       amountPed: map['amountPed'] ?? 1,

  String toJson() => json.encode(toMap());

  factory OderModel.fromJson(String source) =>
      OderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class OderModel {
  final String docIdAssociate;
  final String docPhotopd1;
  final String urlSlip;
  final Timestamp timestamp;
  
  
  
  OderModel({
    required this.docIdAssociate,
    required this.docPhotopd1,
    required this.urlSlip,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docIdAssociate': docIdAssociate,
      'docPhotopd1': docPhotopd1,
      'urlSlip': urlSlip,
      'timestamp': timestamp,
    };
  }

  factory OderModel.fromMap(Map<String, dynamic> map) {
    return OderModel(
      docIdAssociate: (map['docIdAssociate'] ?? '') as String,
      docPhotopd1: (map['docPhotopd1'] ?? '') as String,
      urlSlip: (map['urlSlip'] ?? '') as String,
      timestamp: map['timestamp'],
      //timestamp: map['timestamp'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OderModel.fromJson(String source) => OderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

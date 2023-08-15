// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class CheckAssociateModel {
  final Map<String, dynamic> mapProfile;
  final Timestamp timestamp;
  final bool cheeck;
  final String associateId;
  final String docIdSiteCode;
  final bool? resultAdmin;
  CheckAssociateModel({
    required this.mapProfile,
    required this.timestamp,
    required this.cheeck,
    required this.associateId,
    required this.docIdSiteCode,
    this.resultAdmin,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mapProfile': mapProfile,
      'timestamp': timestamp,
      'cheeck': cheeck,
      'associateId': associateId,
      'docIdSiteCode': docIdSiteCode,
      'resultAdmin': resultAdmin,
    };
  }

  factory CheckAssociateModel.fromMap(Map<String, dynamic> map) {
    return CheckAssociateModel(
      mapProfile: Map<String, dynamic>.from(map['mapProfile'] ?? {}),
      timestamp: (map['timestamp'] ?? Timestamp(0, 0)),
      cheeck: (map['cheeck'] ?? false) as bool,
      associateId: (map['associateId'] ?? '') as String,
      docIdSiteCode: (map['docIdSiteCode'] ?? '') as String,
      resultAdmin: (map['resultAdmin'] ?? true) as bool,
    );
  }
      // mapProfile: Map<String, dynamic>.from(map['mapProfile'] ?? {}),
      // timestamp: (map['timestamp'] ?? Timestamp(0, 0)),
      // cheeck: (map['cheeck'] ?? false) as bool,
      // associateId: (map['associateId'] ?? '') as String,
      // docIdSiteCode: (map['docIdSiteCode'] ?? '') as String,
      // resultAdmin: (map['resultAdmin'] ?? false) as bool,

  String toJson() => json.encode(toMap());

  factory CheckAssociateModel.fromJson(String source) =>
      CheckAssociateModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

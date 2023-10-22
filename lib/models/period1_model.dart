import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Period1Model {
  final String docIdSiteCode;
  final String nameperiod;
  final String periodsale;
  final String saleday;
  final String salesperiod;
  final String roundID;
  final bool? status;
  final bool? repair;
  final bool? statusRound;
  Period1Model({
    required this.docIdSiteCode,
    required this.nameperiod,
    required this.periodsale,
    required this.saleday,
    required this.salesperiod,
    required this.roundID,
    this.status,
    this.repair,
    this.statusRound,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docIdSiteCode': docIdSiteCode,
      'nameperiod': nameperiod,
      'periodsale': periodsale,
      'saleday': saleday,
      'salesperiod': salesperiod,
      'roundID': roundID,
      'status': status,
      'repair': repair,
      'statusRound': statusRound,
    };
  }

  factory Period1Model.fromMap(Map<String, dynamic> map) {
    return Period1Model(
      docIdSiteCode: (map['docIdSiteCode'] ?? '') as String,
      nameperiod: (map['nameperiod'] ?? '') as String,
      periodsale: (map['periodsale'] ?? '') as String,
      saleday: (map['saleday'] ?? '') as String,
      salesperiod: (map['salesperiod'] ?? '') as String,
      roundID: (map['roundID'] ?? '') as String,
      status: map['status'] ?? false,
      repair: map['repair'] ?? false,
      statusRound: map['statusRound'] != false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Period1Model.fromJson(String source) =>
      Period1Model.fromMap(json.decode(source) as Map<String, dynamic>);
}

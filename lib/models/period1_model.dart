import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Period1Model {
  final String periodsale;
  final String associate;
  String saleday;
  String salesperiod;
  Period1Model({
    required this.periodsale,
    required this.associate,
    required this.saleday,
    required this.salesperiod,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'periodsale': periodsale,
      'associate': associate,
      'saleday': saleday,
      'salesperiod': salesperiod,
    };
  }

  factory Period1Model.fromMap(Map<String, dynamic> map) {
    return Period1Model(
      periodsale: (map['periodsale'] ?? '') as String,
      associate: (map['associate'] ?? '') as String,
      saleday: (map['saleday'] ?? '') as String,
      salesperiod: (map['salesperiod'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Period1Model.fromJson(String source) =>
      Period1Model.fromMap(json.decode(source) as Map<String, dynamic>);
}

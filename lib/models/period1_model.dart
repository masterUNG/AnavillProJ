import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Period1Model {
  String saleday;
  String salesperiod;
  Period1Model({
    required this.saleday,
    required this.salesperiod,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'saleday': saleday,
      'salesperiod': salesperiod,
    };
  }

  factory Period1Model.fromMap(Map<String, dynamic> map) {
    return Period1Model(
      saleday: (map['saleday'] ?? '') as String,
      salesperiod: (map['salesperiod'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Period1Model.fromJson(String source) =>
      Period1Model.fromMap(json.decode(source) as Map<String, dynamic>);
}

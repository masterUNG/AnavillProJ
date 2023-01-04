import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Period1Model {
  String period;
  Period1Model({
    required this.period,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'period': period,
    };
  }

  factory Period1Model.fromMap(Map<String, dynamic> map) {
    return Period1Model(
      period: (map['period'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Period1Model.fromJson(String source) => Period1Model.fromMap(json.decode(source) as Map<String, dynamic>);
}

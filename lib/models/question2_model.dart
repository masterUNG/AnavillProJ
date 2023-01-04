import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Question2Model {
  final String ques;
  Question2Model({
    required this.ques,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ques': ques,
    };
  }

  factory Question2Model.fromMap(Map<String, dynamic> map) {
    return Question2Model(
      ques: (map['ques'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Question2Model.fromJson(String source) => Question2Model.fromMap(json.decode(source) as Map<String, dynamic>);
}

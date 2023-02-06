import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProfileModel {
  final String password;
  final String question1;
  final String answer1;
  final String question2;
  final String answer2;
  ProfileModel({
    required this.password,
    required this.question1,
    required this.answer1,
    required this.question2,
    required this.answer2,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'password': password,
      'question1': question1,
      'answer1': answer1,
      'question2': question2,
      'answer2': answer2,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      password: (map['password'] ?? '') as String,
      question1: (map['question1'] ?? '') as String,
      answer1: (map['answer1'] ?? '') as String,
      question2: (map['question2'] ?? '') as String,
      answer2: (map['answer2'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromJson(String source) =>
      ProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

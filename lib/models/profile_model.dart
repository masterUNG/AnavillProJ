import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProfileModel {
  final String password;
  final String question1;
  final String answer1;
  final String question2;
  final String answer2;
  final bool? approve;
  final String phone;
  final String address;
  final String sitecode;
  final String uname;
  final String ulastname;

  ProfileModel({
    required this.password,
    required this.question1,
    required this.answer1,
    required this.question2,
    required this.answer2,
    this.approve,
    required this.phone,
    required this.address,
    required this.sitecode,
    required this.uname,
    required this.ulastname,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'password': password,
      'question1': question1,
      'answer1': answer1,
      'question2': question2,
      'answer2': answer2,
      'approve': approve,
      'phone': phone,
      'address': address,
      'sitecode': sitecode,
      'uname': uname,
      'ulastname': ulastname,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      password: (map['password'] ?? '') as String,
      question1: (map['question1'] ?? '') as String,
      answer1: (map['answer1'] ?? '') as String,
      question2: (map['question2'] ?? '') as String,
      answer2: (map['answer2'] ?? '') as String,
      approve: map['approve'] ?? true,
      phone: (map['phone'] ?? '') as String,
      address: (map['address'] ?? '') as String,
      sitecode: (map['sitecode'] ?? '') as String,
      uname: (map['uname'] ?? '') as String,
      ulastname: (map['ulastname'] ?? '') as String,
    );
  }

  //  password: (map['password'] ?? '') as String,
  //   question1: (map['question1'] ?? '') as String,
  //   answer1: (map['answer1'] ?? '') as String,
  //   question2: (map['question2'] ?? '') as String,
  //   answer2: (map['answer2'] ?? '') as String,
  //   approve: map['approve'] ?? true,

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromJson(String source) =>
      ProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class IphoneModel {
  final String Name;
  final String cover;
  IphoneModel({
    required this.Name,
    required this.cover,
  });

  IphoneModel copyWith({
    String? Name,
    String? cover,
  }) {
    return IphoneModel(
      Name: Name ?? this.Name,
      cover: cover ?? this.cover,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Name': Name,
      'cover': cover,
    };
  }

  factory IphoneModel.fromMap(Map<String, dynamic> map) {
    return IphoneModel(
      Name: (map['Name'] ?? '') as String,
      cover: (map['cover'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory IphoneModel.fromJson(String source) => IphoneModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'IphoneModel(Name: $Name, cover: $cover)';

  @override
  bool operator ==(covariant IphoneModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.Name == Name &&
      other.cover == cover;
  }

  @override
  int get hashCode => Name.hashCode ^ cover.hashCode;
}

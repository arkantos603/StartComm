// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String? id;
  final String? name;
  final String? empresa; 
  final String? email;
  final String? password;

  UserModel({
    this.id,
    this.name,
    this.empresa,
    this.email,
    this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'empresa': empresa,
      'email': email,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      empresa: map['empresa'] != null ? map['empresa'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserModel copyWith({
    String? id,
    String? name,
    String? empresa,
    String? email,
    String? password,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      empresa: empresa ?? this.empresa,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.empresa == empresa &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ empresa.hashCode ^ email.hashCode ^ password.hashCode;
  }
}
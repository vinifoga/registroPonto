import 'package:json_annotation/json_annotation.dart';
import 'package:registroponto/models/roles.dart';

part 'user.g.dart';

@JsonSerializable()
class User{
  late final int id;
  late final String nome;
  late final bool ativo;
  late final String cargo;
  late final String email;
  late List<Roles> roles;

  User({required this.id, required this.nome, required this.ativo, required this.cargo, required this.email, required this.roles});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);




}
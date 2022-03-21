// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      nome: json['nome'] as String,
      ativo: json['ativo'] as bool,
      colaboradorId: json['colaboradorId'] as int,
      email: json['email'] as String,
      roles: (json['roles'] as List<dynamic>)
          .map((e) => Roles.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'ativo': instance.ativo,
      'colaboradorId': instance.colaboradorId,
      'email': instance.email,
      'roles': instance.roles,
    };

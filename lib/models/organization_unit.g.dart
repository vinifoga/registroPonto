// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_unit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrganizationUnit _$OrganizationUnitFromJson(Map<String, dynamic> json) =>
    OrganizationUnit(
      codUnidade: json['codUnidade'],
      descricao: json['descricao'],
      cnpj: json['cnpj'],
      abertura: json['abertura'],
      ativo: json['ativo'] as bool,
      telefone: json['telefone'],
      cep: json['cep'],
      rua: json['rua'],
      numero: json['numero'],
      bairro: json['bairro'],
      cidade: json['cidade'],
      estado: json['estado'],
      horaFuncionaInicio: json['horaFuncionaInicio'],
      horaFuncionaFim: json['horaFuncionaFim'],
    );

Map<String, dynamic> _$OrganizationUnitToJson(OrganizationUnit instance) =>
    <String, dynamic>{
      'codUnidade': instance.codUnidade,
      'descricao': instance.descricao,
      'cnpj': instance.cnpj,
      'abertura': instance.abertura,
      'ativo': instance.ativo,
      'telefone': instance.telefone,
      'cep': instance.cep,
      'rua': instance.rua,
      'numero': instance.numero,
      'bairro': instance.bairro,
      'cidade': instance.cidade,
      'estado': instance.estado,
      'horaFuncionaInicio': instance.horaFuncionaInicio,
      'horaFuncionaFim': instance.horaFuncionaFim,
    };

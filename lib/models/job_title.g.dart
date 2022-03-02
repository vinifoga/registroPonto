// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_title.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobTitle _$JobTitleFromJson(Map<String, dynamic> json) => JobTitle(
      id: json['id'],
      descricao: json['descricao'],
      cbo: json['cbo'],
      departamento:
          Department.fromJson(json['departamento'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$JobTitleToJson(JobTitle instance) => <String, dynamic>{
      'id': instance.id,
      'descricao': instance.descricao,
      'cbo': instance.cbo,
      'departamento': instance.departamento,
    };

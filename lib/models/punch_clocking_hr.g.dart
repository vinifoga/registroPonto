// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'punch_clocking_hr.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PunchClockingHR _$PunchClockingHRFromJson(Map<String, dynamic> json) =>
    PunchClockingHR(
      codRegistro: json['codRegistro'],
      data: json['data'],
      hora: json['hora'],
      status: json['status'],
      colaboradorNome: json['colaboradorNome'],
    );

Map<String, dynamic> _$PunchClockingHRToJson(PunchClockingHR instance) =>
    <String, dynamic>{
      'codRegistro': instance.codRegistro,
      'data': instance.data,
      'hora': instance.hora,
      'status': instance.status,
      'colaboradorNome': instance.colaboradorNome,
    };

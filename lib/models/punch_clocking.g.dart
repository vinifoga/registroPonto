// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'punch_clocking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PunchClocking _$PunchClockingFromJson(Map<String, dynamic> json) =>
    PunchClocking(
      codRegistro: json['codRegistro'],
      data: json['data'],
      hora: json['hora'],
      status: json['status'],
      colaboradorId: json['colaboradorId'],
    );

Map<String, dynamic> _$PunchClockingToJson(PunchClocking instance) =>
    <String, dynamic>{
      'codRegistro': instance.codRegistro,
      'data': instance.data,
      'hora': instance.hora,
      'status': instance.status,
      'colaboradorId': instance.colaboradorId,
    };

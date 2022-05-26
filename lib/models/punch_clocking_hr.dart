import 'package:json_annotation/json_annotation.dart';

part 'punch_clocking_hr.g.dart';

@JsonSerializable()
class PunchClockingHR{
  late final codRegistro;
  late final data;
  late final hora;
  late final status;
  late final colaboradorNome;

  PunchClockingHR({this.codRegistro, this.data, this.hora, this.status, this.colaboradorNome});

  factory PunchClockingHR.fromJson(Map<String, dynamic> json) => _$PunchClockingHRFromJson(json);

  Map<String, dynamic> toJson() => _$PunchClockingHRToJson(this);
}
import 'package:json_annotation/json_annotation.dart';

part 'punch_clocking.g.dart';

@JsonSerializable()
class PunchClocking{
  late final codRegistro;
  late final data;
  late final hora;
  late final status;
  late final colaboradorNome;

  PunchClocking({this.codRegistro, this.data, this.hora, this.status, this.colaboradorNome});

  factory PunchClocking.fromJson(Map<String, dynamic> json) => _$PunchClockingFromJson(json);

  Map<String, dynamic> toJson() => _$PunchClockingToJson(this);
}
import 'package:json_annotation/json_annotation.dart';

import 'department.dart';

part 'job_title.g.dart';

@JsonSerializable()
class JobTitle{
  late final id;
  late final descricao;
  late final cbo;
  late final Department departamento;

  JobTitle({required this.id, required this.descricao, required this.cbo, required this.departamento});

  factory JobTitle.fromJson(Map<String, dynamic> json) => _$JobTitleFromJson(json);

  Map<String, dynamic> toJson() => _$JobTitleToJson(this);

}
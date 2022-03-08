import 'package:json_annotation/json_annotation.dart';

part 'department.g.dart';

@JsonSerializable()
class Department{
  late final id;
  late final descricao;

  Department({this.id, required this.descricao});

  factory Department.fromJson(Map<String, dynamic> json) => _$DepartmentFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentToJson(this);
}
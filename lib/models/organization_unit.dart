import 'package:json_annotation/json_annotation.dart';

part 'organization_unit.g.dart';

@JsonSerializable()
class OrganizationUnit {
  late final codUnidade;
  late final descricao;
  late final cnpj;
  late final abertura;
  late final bool ativo;
  late final telefone;
  late final cep;
  late final rua;
  late final numero;
  late final bairro;
  late final cidade;
  late final estado;
  late final horaFuncionaInicio;
  late final horaFuncionaFim;

  OrganizationUnit({
    this.codUnidade,
    this.descricao,
    this.cnpj,
    this.abertura,
    required this.ativo,
    this.telefone,
    this.cep,
    this.rua,
    this.numero,
    this.bairro,
    this.cidade,
    this.estado,
    this.horaFuncionaInicio,
    this.horaFuncionaFim});

  factory OrganizationUnit.fromJson(Map<String, dynamic> json) => _$OrganizationUnitFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizationUnitToJson(this);
}
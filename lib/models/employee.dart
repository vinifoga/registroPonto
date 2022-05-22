import 'package:json_annotation/json_annotation.dart';

import 'job_title.dart';
import 'organization_unit.dart';

part 'employee.g.dart';

@JsonSerializable()
class Employee{
  late final matricula;
  late final email;
  late final nome;
  late final dataNascimento;
  late final bool ativo;
  late final telefone;
  late final JobTitle cargo;
  late final dataAdmissao;
  late final cpf;
  late final pis;
  late final horaEntra;
  late final horaSai;
  late final intervaloTempo;
  late final bool trabalhaTodosSabados;
  late final bool trabalhaSabadosAlternados;
  late final bool homeOffice;
  late final horaEntraSabado;
  late final horaSaiSabado;
  late OrganizationUnit unidadeOrganizacional;
  late final saldoAcumulado;



  Employee({
      this.matricula,
      this.email,
      this.nome,
      this.dataNascimento,
      required this.ativo,
      this.telefone,
      required this.cargo,
      this.dataAdmissao,
      this.cpf,
      this.pis,
      this.horaEntra,
      this.horaSai,
      this.intervaloTempo,
      required this.trabalhaTodosSabados,
      required this.trabalhaSabadosAlternados,
      required this.homeOffice,
      this.horaEntraSabado,
      this.horaSaiSabado,
      required this.unidadeOrganizacional,
      this.saldoAcumulado});

  factory Employee.fromJson(Map<String, dynamic> json) => _$EmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeToJson(this);
}
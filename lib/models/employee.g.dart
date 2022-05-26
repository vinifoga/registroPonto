// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employee _$EmployeeFromJson(Map<String, dynamic> json) => Employee(
      matricula: json['matricula'],
      email: json['email'],
      nome: json['nome'],
      dataNascimento: json['dataNascimento'],
      ativo: json['ativo'] as bool,
      telefone: json['telefone'],
      cargo: JobTitle.fromJson(json['cargo'] as Map<String, dynamic>),
      dataAdmissao: json['dataAdmissao'],
      cpf: json['cpf'],
      pis: json['pis'],
      horaEntra: json['horaEntra'],
      horaSai: json['horaSai'],
      intervaloTempo: json['intervaloTempo'],
      trabalhaTodosSabados: json['trabalhaTodosSabados'] as bool,
      trabalhaSabadosAlternados: json['trabalhaSabadosAlternados'] as bool,
      homeOffice: json['homeOffice'] as bool,
      horaEntraSabado: json['horaEntraSabado'],
      horaSaiSabado: json['horaSaiSabado'],
      unidadeOrganizacional: OrganizationUnit.fromJson(
          json['unidadeOrganizacional'] as Map<String, dynamic>),
      saldoAcumulado: json['saldoAcumulado'],
    );

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
      'matricula': instance.matricula,
      'email': instance.email,
      'nome': instance.nome,
      'dataNascimento': instance.dataNascimento,
      'ativo': instance.ativo,
      'telefone': instance.telefone,
      'cargo': instance.cargo,
      'dataAdmissao': instance.dataAdmissao,
      'cpf': instance.cpf,
      'pis': instance.pis,
      'horaEntra': instance.horaEntra,
      'horaSai': instance.horaSai,
      'intervaloTempo': instance.intervaloTempo,
      'trabalhaTodosSabados': instance.trabalhaTodosSabados,
      'trabalhaSabadosAlternados': instance.trabalhaSabadosAlternados,
      'homeOffice': instance.homeOffice,
      'horaEntraSabado': instance.horaEntraSabado,
      'horaSaiSabado': instance.horaSaiSabado,
      'unidadeOrganizacional': instance.unidadeOrganizacional,
      'saldoAcumulado': instance.saldoAcumulado,
    };

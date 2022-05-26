import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:registroponto/components/app_bar_rp.dart';
import 'package:registroponto/components/background.dart';
import 'package:registroponto/components/bottom_app_bar_option.dart';
import 'package:registroponto/models/employee.dart';
import 'package:registroponto/models/job_title.dart';
import 'package:registroponto/models/organization_unit.dart';
import 'package:registroponto/models/punch_clocking.dart';
import 'package:registroponto/models/sort_pageable_punch_clocking.dart';
import 'package:registroponto/models/user.dart';
import 'package:registroponto/screens/error_page.dart';
import 'package:registroponto/screens/exit.dart';
import 'package:registroponto/screens/login_screen.dart';
import 'package:registroponto/screens/more_options.dart';
import 'package:registroponto/screens/punch_clocking.dart';
import 'package:registroponto/screens/reclaim_punch_hr.dart';
import 'package:registroponto/screens/upload_file.dart';
import 'package:registroponto/screens/user_list.dart';
import 'package:http/http.dart' as http;


import '../constants.dart';
import '../models/punch_clocking_hr.dart';
import '../models/sort_pageable_punch_clocking_hr.dart';
import 'alerts.dart';
import 'arquives.dart';
import 'employee_list.dart';
import 'organization_unit_list.dart';

Uri url = Uri.parse("https://registro-ponto-api-v2.herokuapp.com/registros");

Uri urlEmployee = Uri.parse("https://registro-ponto-api-v2.herokuapp.com/colaboradores");
late List<Employee> employees = [];

Uri urlUnits = Uri.parse("https://registro-ponto-api-v2.herokuapp.com/unidades");
late List<OrganizationUnit> units = [];

Uri urlUsers = Uri.parse("https://registro-ponto-api-v2.herokuapp.com/usuarios");
late List<User> users = [];

class DashboardHRAnalist extends StatefulWidget {
  final String tokenEnvia;
  final User user;
  const DashboardHRAnalist({Key? key, required this.tokenEnvia, required this.user}) : super(key: key);

  @override
  State<DashboardHRAnalist> createState() => _DashboardHRAnalistState();
}

class _DashboardHRAnalistState extends State<DashboardHRAnalist> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(32.0, 25.0, 32.0, 0.0),
                child: Row(
                  children: [
                    Image.asset(
                      "images/logo-app-bar.png",
                      fit: BoxFit.contain,
                      height: 60,
                    ),
                    SizedBox(width: 20,),
                    const Text('Registro Ponto', style: TextStyle(fontSize: 32, color: kPrimaryColor,),)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32.0, 25.0, 32.0, 0.0),
                child: Row(
                  children: [
                    IconButton(onPressed: () async {
                      late List<PunchClocking> allPunchs = [];
                      findPunchClocking();
                    }, icon: const Icon(Icons.edit), iconSize: 27,),
                    const Text('Correções', style: TextStyle(fontSize: 24),)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Row(
                  children: [
                    IconButton(onPressed: () async{
                      findEmployees();
                    }, icon: const Icon(Icons.person_outline), iconSize: 27,),
                    const Text('Colaboradores', style: TextStyle(fontSize: 24),)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Row(
                  children: [
                    IconButton(onPressed: () async{
                      findOrganizationUnits();
                    }, icon: const Icon(Icons.apartment), iconSize: 27,),
                    const Text('Unidades', style: TextStyle(fontSize: 24),)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Row(
                  children: [
                    IconButton(onPressed: () async{
                      findUsers();
                    }, icon: const Icon(Icons.supervised_user_circle), iconSize: 27,),
                    const Text('Usuários', style: TextStyle(fontSize: 24),)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Row(
                  children: [
                    IconButton(onPressed: () async{
                      Navigator.push(context,
                          MaterialPageRoute(builder : (context) => Arquives()));
                    }, icon: const Icon(Icons.insert_drive_file_sharp), iconSize: 27,),
                    const Text('Arquivos', style: TextStyle(fontSize: 24),)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Row(
                  children: [
                    IconButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                    }, icon: const Icon(Icons.exit_to_app), iconSize: 27,),
                    const Text('Sair', style: TextStyle(fontSize: 24),)
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(50),
                margin: const EdgeInsets.all(50),
                child: Center(
                  child: !_isLoading
                      ? const Text('')
                      : const CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  Future<void> findEmployees() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var response = await http.get(urlEmployee, headers: {
        'Content-type': 'application/json',
        'Authorization': widget.tokenEnvia
      });
      if (response.statusCode == 200) {
        employees = (json.decode(response.body) as List)
            .map((i) => Employee.fromJson(i)).toList();
      } else {
        throw Exception('Falha ao buscar Colaboradores');
      }
    } catch (e) {

    }
    setState(() {
      _isLoading = false;
    });
    Navigator.push(context, MaterialPageRoute(builder: (context) => EmployeeList(tokenEnvia: widget.tokenEnvia, employees: employees)));
  }

  void findOrganizationUnits() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var response = await http.get(urlUnits, headers: {
        'Content-type': 'application/json',
        'Authorization': widget.tokenEnvia
      });
      if (response.statusCode == 200) {
        units = (json.decode(response.body) as List)
            .map((i) => OrganizationUnit.fromJson(i)).toList();
      } else {
        throw Exception('Falha ao buscar Unidades');
      }
    } catch (e) {

    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => OrganizationUnitList(tokenEnvia: widget.tokenEnvia, units: units,)));
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> findUsers() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var response = await http.get(urlEmployee, headers: {
        'Content-type': 'application/json',
        'Authorization': widget.tokenEnvia
      });
      if (response.statusCode == 200) {
        employees = (json.decode(response.body) as List)
            .map((i) => Employee.fromJson(i)).toList();
      } else {
        throw Exception('Falha ao buscar Colaboradores');
      }
    } catch (e) {

    }
    setState(() {
      _isLoading = false;
    });
    try {
      var response = await http.get(urlUsers, headers: {
        'Content-type': 'application/json',
        'Authorization': widget.tokenEnvia
      });
      if (response.statusCode == 200) {
        users = (json.decode(response.body) as List)
            .map((i) => User.fromJson(i)).toList();
      } else {
        throw Exception('Falha ao buscar Usuários');
      }
    } catch (e) {

    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => UserList(tokenEnvia: widget.tokenEnvia, users: users, employees: employees)));
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> findPunchClocking() async {
    List<PunchClockingHR> punchs = [];
    setState(() {
      _isLoading = true;
    });
    Uri urlRegistroColaborador = Uri.parse('https://registro-ponto-api-v2.herokuapp.com/registros/nao-normal');
    try {
      var responsePunch = await http.get(urlRegistroColaborador, headers: {
        'Content-type': 'application/json',
        'Authorization': widget.tokenEnvia
      });
      if (responsePunch.statusCode == 200) {
          punchs = (json.decode(responsePunch.body) as List).map((e) => PunchClockingHR.fromJson(e)).toList();
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder : (context) => ErrorPage()));
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      ('Falha ao buscar Registros');
    }
    Navigator.push(context,
        MaterialPageRoute(builder : (context) => ReclaimPunchHR(punchs: punchs, token: widget.tokenEnvia, user: widget.user,)));
    setState(() {
      _isLoading = false;
    });
  }
}

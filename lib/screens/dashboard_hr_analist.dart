import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:registroponto/components/app_bar_rp.dart';
import 'package:registroponto/components/background.dart';
import 'package:registroponto/components/bottom_app_bar_option.dart';
import 'package:registroponto/models/employee.dart';
import 'package:registroponto/models/organization_unit.dart';
import 'package:registroponto/models/user.dart';
import 'package:registroponto/screens/exit.dart';
import 'package:registroponto/screens/login_screen.dart';
import 'package:registroponto/screens/more_options.dart';
import 'package:registroponto/screens/punch_clocking.dart';
import 'package:registroponto/screens/reclaim_punch_hr.dart';
import 'package:registroponto/screens/upload_file.dart';
import 'package:registroponto/screens/user_list.dart';
import 'package:http/http.dart' as http;


import '../constants.dart';
import 'alerts.dart';
import 'employee_list.dart';
import 'organization_unit_list.dart';

Uri url = Uri.parse("https://registro-ponto-api.herokuapp.com/registros");

Uri urlEmployee = Uri.parse("https://registro-ponto-api.herokuapp.com/colaboradores");
late List<Employee> employees = [];

Uri urlUnits = Uri.parse("https://registro-ponto-api.herokuapp.com/unidades");
late List<OrganizationUnit> units = [];


class DashboardHRAnalist extends StatelessWidget {
  final String tokenEnvia;
  final User user;
  const DashboardHRAnalist({Key? key, required this.tokenEnvia, required this.user}) : super(key: key);


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
                    IconButton(onPressed: () {
                      Navigator.push(context,
                      MaterialPageRoute(builder : (context) => const ReclaimPunchHR()));
                    }, icon: const Icon(Icons.edit), iconSize: 27,),
                    const Text('Correções', style: TextStyle(fontSize: 24),)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Row(
                  children: [
                    IconButton(onPressed: () {
                      findEmployees();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => EmployeeList(tokenEnvia: tokenEnvia, employees: employees)));
                    }, icon: const Icon(Icons.person_outline), iconSize: 27,),
                    const Text('Colaboradores', style: TextStyle(fontSize: 24),)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Row(
                  children: [
                    IconButton(onPressed: () {
                      findOrganizationUnits();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => OrganizationUnitList(tokenEnvia: tokenEnvia, units: units,)));
                    }, icon: const Icon(Icons.apartment), iconSize: 27,),
                    const Text('Unidades', style: TextStyle(fontSize: 24),)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Row(
                  children: [
                    IconButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const UserList()));
                    }, icon: const Icon(Icons.supervised_user_circle), iconSize: 27,),
                    const Text('Usuarios', style: TextStyle(fontSize: 24),)
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
            ],
          ),
        ),
      )
    );
  }

  void findEmployees() async {
    try {
      var response = await http.get(urlEmployee, headers: {
        'Content-type': 'application/json',
        'Authorization': tokenEnvia
      });
      if (response.statusCode == 200) {
        employees = (json.decode(response.body) as List)
            .map((i) => Employee.fromJson(i)).toList();
      } else {
        throw Exception('Falha ao buscar Colaboradores');
      }
    } catch (e) {

    }
  }

  void findOrganizationUnits() async {
    try {
      var response = await http.get(urlUnits, headers: {
        'Content-type': 'application/json',
        'Authorization': tokenEnvia
      });
      if (response.statusCode == 200) {
        units = (json.decode(response.body) as List)
            .map((i) => OrganizationUnit.fromJson(i)).toList();
      } else {
        throw Exception('Falha ao buscar Unidades');
      }
    } catch (e) {

    }
  }
}

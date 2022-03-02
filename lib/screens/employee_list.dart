
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:registroponto/components/app_bar_rp.dart';
import 'package:http/http.dart' as http;
import 'package:registroponto/components/employee_card.dart';
import 'package:registroponto/models/employee.dart';

import '../constants.dart';
import 'employee_register.dart';

class EmployeeList extends StatelessWidget {
  final String tokenEnvia;
  final List<Employee> employees;
  const EmployeeList({Key? key, required this.tokenEnvia, required this.employees}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarRp(
        showBackArrow: true, appBarTitle: 'Colaboradores', showImage: false,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
            itemCount: employees.length,
            itemBuilder: (context, index){
              return GestureDetector(
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text(employees[index].nome),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Cargo: ${employees[index].cargo.descricao}'),
                        Text('Departamento: ${employees[index].cargo.departamento.descricao}'),
                        Text('Status: ${employees[index].ativo}'),
                      ],
                    ),
                    trailing: Icon(
                      Icons.edit,
                    ),
                    tileColor: kPrimaryLightColor,
                  ),
                ),
              );
            }
        ),
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Column(
      //     children: <Widget>[
      //       const Padding(
      //         padding: EdgeInsets.all(16.0),
      //         child: TextField(
      //           decoration: InputDecoration(
      //             border: OutlineInputBorder(),
      //             hintText: 'Digite o nome',
      //             labelText: 'Nome',
      //             suffixIcon: Icon(Icons.search),
      //           ),
      //         ),
      //       ),
      //       EmployeeCard(employess: employees,),
      //       GestureDetector(
      //         onTap: () {
      //           Navigator.push(context, MaterialPageRoute(builder: (context) => EmployeeRegister()));
      //         },
      //         child: Card(
      //           child: ListTile(
      //             leading: Icon(Icons.person),
      //             title: Text('Jorge Matheus Silva'),
      //             subtitle: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Text('Cargo: Estagiário de TI'),
      //                 Text('Departamento: Tecnologia da Informação'),
      //                 Text('Status: Ativo'),
      //               ],
      //             ),
      //             trailing: Icon(
      //               Icons.edit,
      //             ),
      //             tileColor: kPrimaryLightColor,
      //           ),
      //         ),
      //       ),
      //       GestureDetector(
      //         child: Card(
      //           child: ListTile(
      //             leading: Icon(Icons.person),
      //             title: Text('Jorge Matheus Silva'),
      //             subtitle: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Text('Cargo: Estagiário de TI'),
      //                 Text('Departamento: Tecnologia da Informação'),
      //                 Text('Status: Ativo'),
      //               ],
      //             ),
      //             trailing: Icon(
      //               Icons.edit,
      //             ),
      //             tileColor: kPrimaryLightColor,
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }



}



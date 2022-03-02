import 'package:flutter/material.dart';
import 'package:registroponto/models/employee.dart';
import 'package:registroponto/screens/employee_list.dart';

import '../constants.dart';

class EmployeeCard extends StatelessWidget {
  late List<Employee> employees = [];
  EmployeeCard({Key? key, required this.employees}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: employees.length,
      itemBuilder: (context, index){
        return ListTile(
          leading: Icon(Icons.person),
          title: Text(employees[index].nome),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Cargo: Estagiário de TI'),
              Text('Departamento: Tecnologia da Informação'),
              Text('Status: Ativo'),
            ],
          ),
          trailing: Icon(
            Icons.edit,
          ),
          tileColor: kPrimaryLightColor,
        );
      }
    );
  }
}

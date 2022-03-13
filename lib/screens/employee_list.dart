import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:registroponto/components/app_bar_rp.dart';
import 'package:http/http.dart' as http;
import 'package:registroponto/components/employee_card.dart';
import 'package:registroponto/models/employee.dart';
import 'package:registroponto/models/job_title.dart';
import 'package:registroponto/models/organization_unit.dart';

import '../constants.dart';
import 'employee_register.dart';
import 'employee_update.dart';

Uri urlJobTitles = Uri.parse("https://registro-ponto-api.herokuapp.com/cargos");
late List<JobTitle> jobTitles = [];

Uri urlUnits = Uri.parse("https://registro-ponto-api.herokuapp.com/unidades");
late List<OrganizationUnit> units = [];

Uri urlEmployees = Uri.parse("https://registro-ponto-api.herokuapp.com/colaboradores");
late List<Employee> employees = [];

class EmployeeList extends StatefulWidget {
  final String tokenEnvia;
  final List<Employee> employees;

  const EmployeeList(
      {Key? key, required this.tokenEnvia, required this.employees})
      : super(key: key);

  @override
  State<EmployeeList> createState() => _EmployeeListState();

}

class _EmployeeListState extends State<EmployeeList> {
  bool _isLoading = true;
  bool _showError = false;
  late Widget _scaffoldBody;


  @override
  void initState() {
    _scaffoldBody = SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: widget.employees.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
                  background: Container(
                    color: Colors.red,
                    child: const Align(
                      alignment: Alignment(-0.9, 0.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction){
                    setState(() async {
                      await deleteEmployee(widget.employees[index]);
                    });
                  },
                  child: GestureDetector(
                    child: Card(
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text(widget.employees[index].nome),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Cargo: ${widget.employees[index].cargo.descricao}'),
                            Text(
                                'Departamento: ${widget.employees[index].cargo.departamento.descricao}'),
                            Text('Status: ${widget.employees[index].ativo}'),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () async {
                            await updateEmployee(widget.employees[index]);
                          },
                        ),
                        tileColor: kPrimaryLightColor,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(50),
            margin: const EdgeInsets.all(50),
            child: Center(
              child: _isLoading
                  ? const Text('')
                  : const CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarRp(
        showBackArrow: true,
        appBarTitle: 'Colaboradores',
        showImage: false,
      ),
      body: _scaffoldBody,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await findJobTitles();
        },
        backgroundColor: kPrimaryColor,
        child: Icon(Icons.add),
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

  Future<void> findJobTitles() async {
    setState(() {
      _isLoading = false;
    });
    try {
      var response = await http.get(urlJobTitles, headers: {
        'Content-type': 'application/json',
        'Authorization': widget.tokenEnvia
      });
      if (response.statusCode == 200) {
        jobTitles = (json.decode(response.body) as List)
            .map((i) => JobTitle.fromJson(i))
            .toList();
      } else {
        throw Exception('Falha ao buscar Cargos');
      }
    } catch (e) {}
    try {
      var response = await http.get(urlUnits, headers: {
        'Content-type': 'application/json',
        'Authorization': widget.tokenEnvia
      });
      if (response.statusCode == 200) {
        units = (json.decode(response.body) as List)
            .map((i) => OrganizationUnit.fromJson(i))
            .toList();
      } else {
        throw Exception('Falha ao buscar Unidades');
      }
    } catch (e) {}
    setState(() {
      _isLoading = true;
    });
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EmployeeRegister(
                token: widget.tokenEnvia, jobTitles: jobTitles, units: units)));
  }

  Future<void> updateEmployee(Employee employee) async {
    setState(() {
      _isLoading = false;
    });
    try {
      var response = await http.get(urlJobTitles, headers: {
        'Content-type': 'application/json',
        'Authorization': widget.tokenEnvia
      });
      if (response.statusCode == 200) {
        jobTitles = (json.decode(response.body) as List)
            .map((i) => JobTitle.fromJson(i))
            .toList();
      } else {
        throw Exception('Falha ao buscar Cargos');
      }
    } catch (e) {}
    try {
      var response = await http.get(urlUnits, headers: {
        'Content-type': 'application/json',
        'Authorization': widget.tokenEnvia
      });
      if (response.statusCode == 200) {
        units = (json.decode(response.body) as List)
            .map((i) => OrganizationUnit.fromJson(i))
            .toList();
      } else {
        throw Exception('Falha ao buscar Unidades');
      }
    } catch (e) {}
    setState(() {
      _isLoading = true;
    });
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EmployeeUpdate(
                  token: widget.tokenEnvia,
                  jobTitles: jobTitles,
                  units: units,
                  employee: employee,
                )));
  }
  Future<void> deleteEmployee(Employee employee) async {
    setState(() {
      _isLoading = false;
    });
    try {
      Uri urlDeleteEmployee = Uri.parse(urlEmployees.toString()+'/'+employee.matricula.toString());
      var response = await http.delete(urlDeleteEmployee, headers: {
        'Content-type': 'application/json',
        'Authorization': widget.tokenEnvia
      });
      if (response.statusCode == 200) {
       print('Colaborador Excluido');
      } else {
        throw Exception('Falha ao excluir Colaborador');
      }
    } catch (e) {}
    setState(() {
      _isLoading = true;
      findEmployees();
    });

  }

  Future<void> findEmployees() async {
    List<Employee> emploeeysUpdateList = [];
    setState(() {
      _isLoading = true;
    });
    try {
      var response = await http.get(urlEmployees, headers: {
        'Content-type': 'application/json',
        'Authorization': widget.tokenEnvia
      });
      if (response.statusCode == 200) {
        emploeeysUpdateList = (json.decode(response.body) as List)
            .map((i) => Employee.fromJson(i)).toList();
      } else {
        throw Exception('Falha ao buscar Colaboradores');
      }
    } catch (e) {

    }
    setState(() {
      _scaffoldBody = SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: emploeeysUpdateList.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
                    background: Container(
                      color: Colors.red,
                      child: const Align(
                        alignment: Alignment(-0.9, 0.0),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    direction: DismissDirection.startToEnd,
                    onDismissed: (direction){
                      setState(() async {
                        await deleteEmployee(emploeeysUpdateList[index]);
                      });
                    },
                    child: GestureDetector(
                      child: Card(
                        child: ListTile(
                          leading: Icon(Icons.person),
                          title: Text(emploeeysUpdateList[index].nome),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Cargo: ${emploeeysUpdateList[index].cargo.descricao}'),
                              Text(
                                  'Departamento: ${emploeeysUpdateList[index].cargo.departamento.descricao}'),
                              Text('Status: ${emploeeysUpdateList[index].ativo}'),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () async {
                              await updateEmployee(emploeeysUpdateList[index]);
                            },
                          ),
                          tileColor: kPrimaryLightColor,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(50),
              margin: const EdgeInsets.all(50),
              child: Center(
                child: _isLoading
                    ? const Text('')
                    : const CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      );
    });
    _isLoading = false;
  }
}


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:registroponto/components/app_bar_rp.dart';
import 'package:http/http.dart' as http;
import 'package:registroponto/components/employee_card.dart';
import 'package:registroponto/models/employee.dart';
import 'package:registroponto/models/job_title.dart';

import '../constants.dart';
import 'employee_register.dart';

Uri urlJobTitles = Uri.parse("https://registro-ponto-api.herokuapp.com/cargos");
late List<JobTitle> jobTitles = [];

class EmployeeList extends StatefulWidget {
  final String tokenEnvia;
  final List<Employee> employees;
  const EmployeeList({Key? key, required this.tokenEnvia, required this.employees}) : super(key: key);

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  bool _isLoading = false;
  bool _showError = false;
  List<String> teste = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarRp(
        showBackArrow: true, appBarTitle: 'Colaboradores', showImage: false,),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                shrinkWrap: true,
                  itemCount: widget.employees.length,
                  itemBuilder: (context, index){
                    return GestureDetector(
                      child: Card(
                        child: ListTile(
                          leading: Icon(Icons.person),
                          title: Text(widget.employees[index].nome),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Cargo: ${widget.employees[index].cargo.descricao}'),
                              Text('Departamento: ${widget.employees[index].cargo.departamento.descricao}'),
                              Text('Status: ${widget.employees[index].ativo}'),
                            ],
                          ),
                          trailing: Icon(
                            Icons.edit,
                          ),
                          tileColor: kPrimaryLightColor,
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
      ),


      floatingActionButton: FloatingActionButton(

        onPressed: () async{
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
            .map((i) => JobTitle.fromJson(i)).toList();

      } else {
        throw Exception('Falha ao buscar Cargos');
      }
    } catch (e) {

    }
    setState(() {
      _isLoading = true;
    });
    Navigator.push(context, MaterialPageRoute(builder: (context) => EmployeeRegister(token : widget.tokenEnvia, jobTitles : jobTitles)));
  }
}



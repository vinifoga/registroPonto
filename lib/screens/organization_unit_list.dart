import 'package:flutter/material.dart';
import 'package:registroponto/components/app_bar_rp.dart';
import 'package:registroponto/models/organization_unit.dart';
import 'package:registroponto/screens/organization_unit_update.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants.dart';
import 'employee_register.dart';
import 'organization_unit_register.dart';

Uri urlUnit = Uri.parse("https://registro-ponto-api.herokuapp.com/unidades");

class OrganizationUnitList extends StatefulWidget {
  final String tokenEnvia;
  final List<OrganizationUnit> units;

  const OrganizationUnitList(
      {Key? key, required this.tokenEnvia, required this.units})
      : super(key: key);

  @override
  State<OrganizationUnitList> createState() => _OrganizationUnitListState();
}

class _OrganizationUnitListState extends State<OrganizationUnitList> {
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
                itemCount: widget.units.length,
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
                    onDismissed: (direction) {
                      setState(() async {
                        await deleteUnit(widget.units[index]);
                      });
                    },
                    child: GestureDetector(
                      child: Card(
                        child: ListTile(
                          leading: Icon(Icons.apartment),
                          title: Text(widget.units[index].descricao),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('CNPJ: ${widget.units[index].cnpj}'),
                              Text(
                                  'End.: ${widget.units[index].rua}, ${widget.units[index].numero} - ${widget.units[index].bairro}'),
                              Text('Status: ${widget.units[index].ativo}'),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () async {
                              await updateUnit(widget.units[index]);
                            },
                          ),
                          tileColor: kPrimaryLightColor,
                        ),
                      ),
                    ),
                  );
                }),
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
        appBarTitle: 'Unidades',
        showImage: false,
      ),
      body: _scaffoldBody,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OrganizationUnitRegister(
                        token: widget.tokenEnvia,
                      )));
        },
        backgroundColor: kPrimaryColor,
        child: Icon(Icons.add),
      ),

      // body: ListView(
      //   padding: const EdgeInsets.all(8),
      //   children: <Widget>[
      //     const Padding(
      //       padding: EdgeInsets.all(16.0),
      //       child: TextField(
      //         decoration: InputDecoration(
      //           border: OutlineInputBorder(),
      //           hintText: 'Digite o nome',
      //           labelText: 'Nome',
      //           suffixIcon: Icon(Icons.search),
      //         ),
      //       ),
      //     ),
      //     GestureDetector(
      //       onTap: () {
      //         Navigator.push(context, MaterialPageRoute(builder: (context) => OrganizationUnitRegister()));
      //       },
      //       child: Card(
      //         child: ListTile(
      //           leading: Icon(Icons.apartment),
      //           title: Text('Loja 1 - Matriz'),
      //           subtitle: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Text('CNPJ: 15.874.696.0001-85'),
      //               Text('End.: Avenidade Belo Horizonte, 179 - Bairro Brasil'),
      //             ],
      //           ),
      //           trailing: Icon(
      //             Icons.edit,
      //           ),
      //           tileColor: kPrimaryLightColor,
      //         ),
      //       ),
      //     ),
      //     GestureDetector(
      //       onTap: () {
      //         Navigator.push(context, MaterialPageRoute(builder: (context) => OrganizationUnitRegister()));
      //       },
      //       child: Card(
      //         child: ListTile(
      //           leading: Icon(Icons.apartment),
      //           title: Text('Loja 2 - Salto'),
      //           subtitle: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Text('CNPJ: 15.874.696.0002-98'),
      //               Text('End.: Rua Capitão Alfredo Cardoso, 474 - Jardim Faculdade'),
      //             ],
      //           ),
      //           trailing: Icon(
      //             Icons.edit,
      //           ),
      //           tileColor: kPrimaryLightColor,
      //         ),
      //       ),
      //     ),
      //
      //   ],
      // ),
    );
  }

  Future<void> updateUnit(OrganizationUnit unit) async {
    setState(() {
      _isLoading = false;
    });
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                OrganizationUnitUpdate(token: widget.tokenEnvia, unit: unit)));
  }

  Future<void> deleteUnit(OrganizationUnit unit) async {
    setState(() {
      _isLoading = false;
    });
    try {
      Uri urlDeleteUnit =
          Uri.parse(urlUnit.toString() + '/' + unit.codUnidade.toString());
      var response = await http.delete(urlDeleteUnit, headers: {
        'Content-type': 'application/json',
        'Authorization': widget.tokenEnvia
      });
      if (response.statusCode == 200) {
        print('Unidade Excluida');
      } else {
        throw Exception('Falha ao excluir Unidade');
      }
    } catch (e) {}
    setState(() {
      _isLoading = true;
      findUnits();
    });
  }

  Future<void> findUnits() async {
    List<OrganizationUnit> unitsUpdateList = [];
    setState(() {
      _isLoading = true;
    });
    try {
      var response = await http.get(urlUnit, headers: {
        'Content-type': 'application/json',
        'Authorization': widget.tokenEnvia
      });
      if (response.statusCode == 200) {
        unitsUpdateList = (json.decode(response.body) as List)
            .map((i) => OrganizationUnit.fromJson(i))
            .toList();
      } else {
        throw Exception('Falha ao buscar Unidades');
      }
    } catch (e) {
      print(e);
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
                  itemCount: unitsUpdateList.length,
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
                      onDismissed: (direction) {
                        setState(() async {
                          await deleteUnit(widget.units[index]);
                        });
                      },
                      child: GestureDetector(
                        child: Card(
                          child: ListTile(
                            leading: Icon(Icons.apartment),
                            title: Text(unitsUpdateList[index].descricao),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('CNPJ: ${unitsUpdateList[index].cnpj}'),
                                Text(
                                    'End.: ${unitsUpdateList[index].rua}, ${unitsUpdateList[index].numero} - ${unitsUpdateList[index].bairro}'),
                                Text('Status: ${unitsUpdateList[index].ativo}'),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () async {
                                await updateUnit(unitsUpdateList[index]);
                              },
                            ),
                            tileColor: kPrimaryLightColor,
                          ),
                        ),
                      ),
                    );
                  }),
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

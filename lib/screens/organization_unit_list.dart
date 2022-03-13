
import 'package:flutter/material.dart';
import 'package:registroponto/components/app_bar_rp.dart';
import 'package:registroponto/models/organization_unit.dart';
import 'package:registroponto/screens/organization_unit_update.dart';

import '../constants.dart';
import 'employee_register.dart';
import 'organization_unit_register.dart';

class OrganizationUnitList extends StatefulWidget {
  final String tokenEnvia;
  final List<OrganizationUnit> units;
  OrganizationUnitList({Key? key, required this.tokenEnvia, required this.units}) : super(key: key);

  @override
  State<OrganizationUnitList> createState() => _OrganizationUnitListState();
}

class _OrganizationUnitListState extends State<OrganizationUnitList> {
  bool _isLoading = true;
  bool _showError = false;
  late Widget _scaffoldBody;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarRp(
        showBackArrow: true, appBarTitle: 'Unidades', showImage: false,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
            itemCount: widget.units.length,
            itemBuilder: (context, index){
              return GestureDetector(
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.apartment),
                    title: Text(widget.units[index].descricao),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('CNPJ: ${widget.units[index].cnpj}'),
                        Text('End.: ${widget.units[index].rua}, ${widget.units[index].numero} - ${widget.units[index].bairro}'),
                        Text('Status: ${widget.units[index].ativo}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon : Icon(Icons.edit),
                      onPressed: () async {
                        await updateUnit(widget.units[index]);
                      },
                    ),
                    tileColor: kPrimaryLightColor,
                  ),
                ),
              );
            }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => OrganizationUnitRegister(token: widget.tokenEnvia,)));
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
    Navigator.push(context, MaterialPageRoute(builder: (context) => OrganizationUnitUpdate(token: widget.tokenEnvia, unit: unit)));
}
}



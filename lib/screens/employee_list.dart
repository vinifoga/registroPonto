import 'package:flutter/material.dart';
import 'package:registroponto/components/app_bar_rp.dart';

import '../constants.dart';

class EmployeeList extends StatelessWidget {
  const EmployeeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarRp(showBackArrow: true, appBarTitle: 'Colaboradores', showImage: false,),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          GestureDetector(
            child: Card(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('Jorge Matheus Silva'),
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
              ),
            ),
          ),
          GestureDetector(
            child: Card(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('Jorge Matheus Silva'),
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
              ),
            ),
          ),
        ],
      ),


    );
  }
}

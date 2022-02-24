
import 'package:flutter/material.dart';
import 'package:registroponto/components/app_bar_rp.dart';

import '../constants.dart';
import 'employee_register.dart';
import 'organiztion_unit_register.dart';

class OrganizationUnitList extends StatelessWidget {
  const OrganizationUnitList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarRp(
        showBackArrow: true, appBarTitle: 'Unidades', showImage: false,),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Digite o nome',
                labelText: 'Nome',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => OrganizationUnitRegister()));
            },
            child: Card(
              child: ListTile(
                leading: Icon(Icons.apartment),
                title: Text('Loja 1 - Matriz'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('CNPJ: 15.874.696.0001-85'),
                    Text('End.: Avenidade Belo Horizonte, 179 - Bairro Brasil'),
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
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => OrganizationUnitRegister()));
            },
            child: Card(
              child: ListTile(
                leading: Icon(Icons.apartment),
                title: Text('Loja 2 - Salto'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('CNPJ: 15.874.696.0002-98'),
                    Text('End.: Rua Capitão Alfredo Cardoso, 474 - Jardim Faculdade'),
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


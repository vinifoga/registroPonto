
import 'package:flutter/material.dart';
import 'package:registroponto/components/app_bar_rp.dart';
import 'package:registroponto/models/user.dart';
import 'package:registroponto/screens/user_register.dart';

import '../constants.dart';
import 'employee_register.dart';

class UserList extends StatelessWidget {
  final String tokenEnvia;
  final List<User> users;
  UserList({Key? key, required this.tokenEnvia, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarRp(
        showBackArrow: true, appBarTitle: 'Usuários', showImage: false,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index){
              return GestureDetector(
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text(users[index].nome),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email: ${users[index].email}'),
                        Text('Perfil: ${users[index].roles.first.nomeRole}'),
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
/*
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => UserRegister()));
            },
            child: Card(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('Vinícius Fernandes Fogaça'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Cargo: Desenvolvedor Júnior'),
                    Text('Nível de Acesso: Colaborador'),
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
*/
    );
  }
}



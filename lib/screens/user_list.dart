
import 'package:flutter/material.dart';
import 'package:registroponto/components/app_bar_rp.dart';
import 'package:registroponto/models/employee.dart';
import 'package:registroponto/models/roles.dart';
import 'package:registroponto/models/user.dart';
import 'package:registroponto/screens/user_register.dart';
import 'package:http/http.dart' as http;
import 'package:registroponto/screens/user_update.dart';
import 'dart:convert';


import '../constants.dart';
import 'employee_register.dart';

Uri urlRoles = Uri.parse("https://registro-ponto-api-v2.herokuapp.com/roles");
late List<Roles> roles = [];

Uri urlEmployees = Uri.parse("https://registro-ponto-api-v2.herokuapp.com/colaboradores");
late List<Employee> employees = [];

Uri urlUsers = Uri.parse("https://registro-ponto-api-v2.herokuapp.com/usuarios");

class UserList extends StatefulWidget {
  final String tokenEnvia;
  final List<User> users;
  final List<Employee> employees;
  UserList({Key? key, required this.tokenEnvia, required this.users, required this.employees}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  bool _isLoading = true;
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
                itemCount: widget.users.length,
                itemBuilder: (context, index){
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
                        await deleteUser(widget.users[index]);
                      });
                    },
                    child: GestureDetector(
                      child: Card(
                        child: ListTile(
                          leading: Icon(Icons.person),
                          title: Text(widget.users[index].nome),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Email: ${widget.users[index].email}'),
                              Text('Perfil: ${widget.users[index].roles.first.nomeRole}'),
                            ],
                          ),
                          trailing: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () async {
                                await updateUser(widget.users[index]);
                              }
                          ),
                          tileColor: kPrimaryLightColor,
                        ),
                      ),
                    ),
                  );
                }
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
      appBar: AppBarRp(
        showBackArrow: true, appBarTitle: 'Usuários', showImage: false,),
      body: _scaffoldBody,
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await createUser(context);
        },
        backgroundColor: kPrimaryColor,
        child: Icon(Icons.add),
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

  Future<void> createUser(BuildContext context) async{
    try {
      var response = await http.get(urlRoles, headers: {
        'Content-type': 'application/json',
        'Authorization': widget.tokenEnvia
      });
      if (response.statusCode == 200) {
        roles = (json.decode(response.body) as List)
            .map((i) => Roles.fromJson(i)).toList();
      } else {
        throw Exception('Falha ao buscar Roles');
      }
    } catch (e) {

    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => UserRegister(token: widget.tokenEnvia, employees: widget.employees, roles : roles)));

  }

  Future<void> updateUser(User user) async {
    setState(() {
      _isLoading = false;
    });
    try{
      var response = await http.get(urlEmployees, headers: {
        'Content-type': 'application/json',
        'Authorization': widget.tokenEnvia
      });
      if(response.statusCode == 200){
        employees = (json.decode(response.body) as List)
            .map((e) => Employee.fromJson(e))
            .toList();
      } else {
        throw Exception('Falha ao buscar Colaboradores');
      }
    } catch (e){}
    try{
      var response = await http.get(urlRoles, headers: {
        'Content-type': 'application/json',
        'Authorization': widget.tokenEnvia
      });
      if(response.statusCode == 200){
        roles = (json.decode(response.body) as List)
            .map((e) => Roles.fromJson(e))
            .toList();
      } else {
        throw Exception('Falha ao buscar Roles');
      }
    } catch (e){}
    setState(() {
      _isLoading = true;
    });
    Navigator.push(context, MaterialPageRoute(builder: (context) => UserUpdate(
      token: widget.tokenEnvia,
      employees : employees,
      roles: roles,
      user : user,
    )));
  }

  Future<void> deleteUser(User user) async {
    setState(() {
      _isLoading = false;
    });
    try{
      Uri urlDeleteUser = Uri.parse(urlUsers.toString()+'/'+user.id.toString());
      var response = await http.delete(urlDeleteUser, headers: {
        'Content-type': 'application/json',
        'Authorization': widget.tokenEnvia
      });
      if(response.statusCode == 200){
        print('Usuario Excluído');
      } else {
        throw Exception('Falha ao excluir usuário');
      }
    } catch (e){}
    setState(() {
      findUsers();
    });
  }

  Future<void> findUsers() async {
    List<User> usersUpdateList = [];
    setState(() {
      _isLoading = true;
    });
    try {
      var response = await http.get(urlUsers, headers: {
        'Content-type': 'application/json',
        'Authorization': widget.tokenEnvia
      });
      if(response.statusCode == 200){
        usersUpdateList = (json.decode(response.body) as List)
            .map((e) => User.fromJson(e)).toList();
      } else {
        throw Exception('Falha ao buscar usuários');
      }
    } catch (e){}
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
                  itemCount: usersUpdateList.length,
                  itemBuilder: (context, index){
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
                          await deleteUser(usersUpdateList[index]);
                        });
                      },
                      child: GestureDetector(
                        child: Card(
                          child: ListTile(
                            leading: Icon(Icons.person),
                            title: Text(usersUpdateList[index].nome),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Email: ${usersUpdateList[index].email}'),
                                Text('Perfil: ${usersUpdateList[index].roles.first.nomeRole}'),
                              ],
                            ),
                            trailing: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () async {
                                  await updateUser(usersUpdateList[index]);
                                }
                            ),
                            tileColor: kPrimaryLightColor,
                          ),
                        ),
                      ),
                    );
                  }
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
  }
}



import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:registroponto/components/app_bar_rp.dart';
import 'package:registroponto/components/bottom_app_bar_option.dart';
import 'package:registroponto/models/punch_clocking.dart';
import 'package:registroponto/models/sort_pageable_punch_clocking.dart';
import 'package:registroponto/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:registroponto/screens/exit.dart';
import 'package:registroponto/screens/login_screen.dart';
import 'package:registroponto/screens/more_options.dart';
import 'package:registroponto/screens/punch_clocking.dart';
import 'package:registroponto/screens/reclaim_punch.dart';
import 'package:registroponto/screens/reclaim_punch_hr.dart';
import 'package:registroponto/screens/sick_note.dart';
import 'package:registroponto/screens/upload_file.dart';

import '../constants.dart';
import 'alerts.dart';
import 'balance.dart';

Uri url = Uri.parse("https://registro-ponto-api.herokuapp.com/registros");
late List<PunchClocking> punchs = [];

class Dashboard extends StatelessWidget {
  final String tokenEnvia;
  final User user;

  const Dashboard({Key? key, required this.tokenEnvia, required this.user})
      : super(key: key);

  void findPunchClocking() async {
    Uri urlRegistros = Uri.parse(
        'https://registro-ponto-api.herokuapp.com/registros?colaboradorId=${user
            .id}');
    try {
      var responsePunch = await http.get(urlRegistros, headers: {
        'Content-type': 'application/json',
        'Authorization': tokenEnvia
      });
      if (responsePunch.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(responsePunch.body.toString());
        SortPageablePunchClocking sortPageablePunchClocking = SortPageablePunchClocking
            .fromJson(map);
        punchs = sortPageablePunchClocking.content;
      } else {
        throw Exception('Falha ao buscar Registros');
      }
    } catch (e) {

    }
  }

  @override
  Widget build(BuildContext context) {
    findPunchClocking();
    return Scaffold(
      appBar: const AppBarRp(appBarTitle: 'Últimas Marcações',
        showImage: true,
        showBackArrow: true,),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Card(
            child: ListTile(
              title: Text(punchs[3].colaboradorNome),
              subtitle: Text(punchs[3].data.toString().substring(8, 10) + '/'
                  + punchs[3].data.toString().substring(5, 7) + '/'
                  + punchs[3].data.toString().substring(0, 4) + '    '
                  + punchs[3].hora.toString()),
              trailing: Icon(
                Icons.call_received,
                color: Colors.green,
              ),
              tileColor: kPrimaryLightColor,
            ),
          ),
          Card(
            child: ListTile(
              title: Text(punchs[2].colaboradorNome),
              subtitle: Text(punchs[2].data.toString().substring(8, 10) + '/'
                  + punchs[2].data.toString().substring(5, 7) + '/'
                  + punchs[2].data.toString().substring(0, 4) + '   '
                  + punchs[2].hora.toString()),
              trailing: Icon(
                Icons.call_made,
                color: Colors.red,
              ),
              tileColor: kPrimaryLightColor,
            ),
          ), Card(
            child: ListTile(
              title: Text(punchs[1].colaboradorNome),
              subtitle: Text(punchs[1].data.toString().substring(8, 10) + '/'
                  + punchs[1].data.toString().substring(5, 7) + '/'
                  + punchs[1].data.toString().substring(0, 4) + '    '
                  + punchs[1].hora.toString()),
              trailing: Icon(
                Icons.call_received,
                color: Colors.green,
              ),
              tileColor: kPrimaryLightColor,
            ),
          ), Card(
            child: ListTile(
              title: Text(punchs[0].colaboradorNome),
              subtitle: Text(punchs[0].data.toString().substring(8, 10) + '/'
                  + punchs[0].data.toString().substring(5, 7) + '/'
                  + punchs[0].data.toString().substring(0, 4) + '    '
                  + punchs[0].hora.toString()),
              trailing: Icon(
                Icons.call_made,
                color: Colors.red,
              ),
              tileColor: kPrimaryLightColor,
            ),
          ),

          GestureDetector(
              child: Card(
                child: ListTile(
                  title: Text('Ver mais'),
                  trailing: Icon(
                    Icons.add,
                    color: Colors.blue,
                  ),
                  tileColor: kPrimaryLightColor,
                ),
              ),
              onTap: () =>
              {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PunchClockingScreen(),
                  ),
                )
              }),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: kPrimaryLightColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Text('Registro Ponto',
                  style: GoogleFonts.k2d(
                    fontSize: 32.0,
                    color: floatActionButtonColor,
                  ),),
              ),
              Row(
                children: [
                  IconButton(onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder : (context) => Balance()));

                  }, icon: const Icon(Icons.account_balance), iconSize: 27,),
                  const Text('Saldo', style: TextStyle(fontSize: 24),)
                ],
              ),
              Row(
                children: [
                  IconButton(onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder : (context) => const Alerts()));

                  }, icon: const Icon(Icons.warning), iconSize: 27,),
                  const Text('Alertas', style: TextStyle(fontSize: 24),)
                ],
              ),
              Row(
                children: [
                  IconButton(onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder : (context) => const SickNote()));

                  }, icon: const Icon(Icons.now_wallpaper), iconSize: 27,),
                  const Text('Enviar Atestado', style: TextStyle(fontSize: 24),)
                ],
              ),
              Row(
                children: [
                  IconButton(onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder : (context) => PunchClockingScreen()));

                  }, icon: const Icon(Icons.edit), iconSize: 27,),
                  const Text('Correções', style: TextStyle(fontSize: 24),)
                ],
              ),
              Row(
                children: [
                  IconButton(onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder : (context) => const LoginScreen()));

                  }, icon: const Icon(Icons.exit_to_app), iconSize: 27,),
                  const Text('Sair', style: TextStyle(fontSize: 24),)
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: floatActionButtonColor,
        onPressed: () {},
        child: const Icon(Icons.fingerprint), //icon inside button
      ),
    );
  }
}

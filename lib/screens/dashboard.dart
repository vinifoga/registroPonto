import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:registroponto/components/app_bar_rp.dart';
import 'package:registroponto/models/punch_clocking.dart';
import 'package:registroponto/models/sort_pageable_punch_clocking.dart';
import 'package:registroponto/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:registroponto/screens/login_screen.dart';
import 'package:registroponto/screens/punch_clocking.dart';
import 'package:registroponto/screens/sick_note.dart';

import '../constants.dart';
import 'alerts.dart';
import 'balance.dart';

Uri url = Uri.parse("https://registro-ponto-api.herokuapp.com/registros");
late List<PunchClocking> punchs = [];

class Dashboard extends StatefulWidget {
  final String tokenEnvia;
  final User user;

  const Dashboard({Key? key, required this.tokenEnvia, required this.user})
      : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String qrcodeResult = '';
  void findPunchClocking() async {
    Uri urlRegistros = Uri.parse(
        'https://registro-ponto-api.herokuapp.com/registros?colaboradorId=${widget.user
            .id}');
    try {
      var responsePunch = await http.get(urlRegistros, headers: {
        'Content-type': 'application/json',
        'Authorization': widget.tokenEnvia
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
      ('Falha ao buscar Registros');
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
          // Card(
          //   child: ListTile(
          //     title: Text(punchs[punchs.length].colaboradorNome),
          //     subtitle: Text(punchs[punchs.length].data.toString().substring(8, 10) + '/'
          //         + punchs[punchs.length].data.toString().substring(5, 7) + '/'
          //         + punchs[punchs.length].data.toString().substring(0, 4) + '    '
          //         + punchs[punchs.length].hora.toString()),
          //     trailing: const Icon(
          //       Icons.call_received,
          //       color: Colors.green,
          //     ),
          //     tileColor: kPrimaryLightColor,
          //   ),
          // ),

          GestureDetector(
              child: const Card(
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
          Text(qrcodeResult),
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
                        MaterialPageRoute(builder: (context) => Balance()));
                  }, icon: const Icon(Icons.account_balance), iconSize: 27,),
                  const Text('Saldo', style: TextStyle(fontSize: 24),)
                ],
              ),
              Row(
                children: [
                  IconButton(onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Alerts()));
                  }, icon: const Icon(Icons.warning), iconSize: 27,),
                  const Text('Alertas', style: TextStyle(fontSize: 24),)
                ],
              ),
              Row(
                children: [
                  IconButton(onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => const SickNote()));
                  }, icon: const Icon(Icons.now_wallpaper), iconSize: 27,),
                  const Text('Enviar Atestado', style: TextStyle(fontSize: 24),)
                ],
              ),
              Row(
                children: [
                  IconButton(onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => PunchClockingScreen()));
                  }, icon: const Icon(Icons.edit), iconSize: 27,),
                  const Text('Correções', style: TextStyle(fontSize: 24),)
                ],
              ),
              Row(
                children: [
                  IconButton(onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
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
        onPressed: readQRCode,
        child: const Icon(Icons.fingerprint), //icon inside button
      ),
    );
  }

  //Colocar em um try
  readQRCode() async {
    print('eraqwe');
    String code = await FlutterBarcodeScanner.scanBarcode(
      "#FFFFFF",
      "Cancelar",
      false,
      ScanMode.QR,
    );
    setState(() => qrcodeResult = code != '-1' ? code : 'Falha ao ler QRCode');
  }
}

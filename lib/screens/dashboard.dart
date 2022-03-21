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
  final List<PunchClocking> punchs;

  const Dashboard({Key? key, required this.tokenEnvia, required this.user, required this.punchs, })
      : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String qrcodeResult = '';
  bool _isLoading = false;
  bool _showError = false;
  late Widget _scaffoldBody;
  Uri urlRegistros = Uri.parse(
      'https://registro-ponto-api.herokuapp.com/registros');


  @override
  void initState() {
    super.initState();
    _scaffoldBody = SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: widget.punchs.length,
              itemBuilder: (context, index){
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.hourglass_bottom),
                    title: Text(widget.punchs[index].status),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Data: ${widget.punchs[index].data}'),
                        Text('Hora: ${widget.punchs[index].hora}'),
                      ],
                    ),
                  ),
                );
              },
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
            ),
          ),
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
              onTap: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PunchClockingScreen(),
                  ),
                )
              }),
          Text(qrcodeResult),
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
        appBarTitle: 'Últimas Marcações',
        showImage: true,
        showBackArrow: true,
      ),
      body: _scaffoldBody,
      drawer: Drawer(
        child: Container(
          color: kPrimaryLightColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Text(
                  'Registro Ponto',
                  style: GoogleFonts.k2d(
                    fontSize: 32.0,
                    color: floatActionButtonColor,
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Balance()));
                    },
                    icon: const Icon(Icons.account_balance),
                    iconSize: 27,
                  ),
                  const Text(
                    'Saldo',
                    style: TextStyle(fontSize: 24),
                  )
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Alerts()));
                    },
                    icon: const Icon(Icons.warning),
                    iconSize: 27,
                  ),
                  const Text(
                    'Alertas',
                    style: TextStyle(fontSize: 24),
                  )
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SickNote()));
                    },
                    icon: const Icon(Icons.now_wallpaper),
                    iconSize: 27,
                  ),
                  const Text(
                    'Enviar Atestado',
                    style: TextStyle(fontSize: 24),
                  )
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PunchClockingScreen()));
                    },
                    icon: const Icon(Icons.edit),
                    iconSize: 27,
                  ),
                  const Text(
                    'Correções',
                    style: TextStyle(fontSize: 24),
                  )
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    icon: const Icon(Icons.exit_to_app),
                    iconSize: 27,
                  ),
                  const Text(
                    'Sair',
                    style: TextStyle(fontSize: 24),
                  )
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
    setState(() {
      _isLoading = true;
    });
    String code = await FlutterBarcodeScanner.scanBarcode(
      "#FFFFFF",
      "Cancelar",
      false,
      ScanMode.QR,
    );
    setState(() => qrcodeResult = code != '-1' ? code : 'Falha ao ler QRCode');
    if (code != '-1') {
      final splitted = qrcodeResult.split(';');
      try {

        Map<String, String> header = {
          'Content-type': 'application/json',
          'Authorization': widget.tokenEnvia
        };

        final body = jsonEncode({
          "data": splitted[0],
          "hora": splitted[1],
          "status": splitted[2],
          "colaboradorId": widget.user.colaboradorId
        });

        var responseUser = await http.post(url,
            headers: header,
            body: body);
        if (responseUser.statusCode == 201) {
          print('Registro Salvo');
          updateList;
        } else {
          print(responseUser.statusCode);
          print('Erro ao salvar Registro');
        }

      } catch (e) {
        setState(() {
          _isLoading = false;
          _showError = true;
        });
      }
      setState(() {
        updateList();
        _isLoading = false;
      });
    }

  }

  Future<void> updateList() async {
    late List<PunchClocking> punchsUpdated = [];
    Uri urlRegistroColaborador = Uri.parse(urlRegistros.toString()+'?colaboradorId=${widget.user.id}');
    try {
      var responsePunch = await http.get(urlRegistroColaborador, headers: {
        'Content-type': 'application/json',
        'Authorization': widget.tokenEnvia
      });
      if (responsePunch.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(responsePunch.body.toString());
        SortPageablePunchClocking sortPageablePunchClocking =
        SortPageablePunchClocking.fromJson(map);
        punchsUpdated = sortPageablePunchClocking.content;
      } else {
        throw Exception('Falha ao buscar Registros');
      }
    } catch (e) {
      ('Falha ao buscar Registros');
    }
    setState(() {
      _isLoading = true;
      _scaffoldBody = SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: punchsUpdated.length,
                itemBuilder: (context, index){
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.hourglass_bottom),
                      title: Text(punchsUpdated[index].status),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Data: ${punchsUpdated[index].data}'),
                          Text('Hora: ${punchsUpdated[index].hora}'),
                        ],
                      ),
                    ),
                  );
                },
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
              ),
            ),
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
                onTap: () => {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PunchClockingScreen(),
                    ),
                  )
                }),
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

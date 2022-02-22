import 'package:flutter/material.dart';
import 'package:registroponto/components/app_bar_rp.dart';
import 'package:registroponto/components/bottom_app_bar_option.dart';
import 'package:registroponto/screens/exit.dart';
import 'package:registroponto/screens/more_options.dart';
import 'package:registroponto/screens/punch_clocking.dart';
import 'package:registroponto/screens/reclaim_punch_hr.dart';
import 'package:registroponto/screens/upload_file.dart';

import '../constants.dart';
import 'alerts.dart';

Uri url = Uri.parse("https://registro-ponto-api.herokuapp.com/registros");

class DashboardHRAnalist extends StatelessWidget {
  const DashboardHRAnalist(String tokenEnvia, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarRp(appBarTitle: 'Registro Ponto', showImage: true, showBackArrow: false,),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(32.0, 25.0, 32.0, 0.0),
            child: Row(
              children: [
                IconButton(onPressed: () {
                  Navigator.push(context,
                  MaterialPageRoute(builder : (context) => ReclaimPunchHR()));

                }, icon: const Icon(Icons.edit), iconSize: 27,),
                const Text('Correções', style: TextStyle(fontSize: 24),)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Row(
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.person_outline), iconSize: 27,),
                const Text('Colaboradores', style: TextStyle(fontSize: 24),)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Row(
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.apartment), iconSize: 27,),
                const Text('Unidades', style: TextStyle(fontSize: 24),)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Row(
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.supervised_user_circle), iconSize: 27,),
                const Text('Usuarios', style: TextStyle(fontSize: 24),)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Row(
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.exit_to_app), iconSize: 27,),
                const Text('Sair', style: TextStyle(fontSize: 24),)
              ],
            ),
          ),
        ],
      )
    );
  }
}

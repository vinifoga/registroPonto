import 'package:flutter/material.dart';
import 'package:registroponto/components/app_bar_rp.dart';
import 'package:registroponto/components/bottom_app_bar_option.dart';
import 'package:registroponto/screens/exit.dart';

import '../constants.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarRp(appBarTitle: 'Últimas Marcações', showImage: true),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: const <Widget>[
          Card(
            child: ListTile(
              title: Text('Entrada'),
              subtitle: Text('02/09/2021 - 8:00'),
              trailing: Icon(
                Icons.call_received,
                color: Colors.green,
              ),
              tileColor: kPrimaryLightColor,
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Saída'),
              subtitle: Text('02/09/2021 - 8:00'),
              trailing: Icon(
                Icons.call_made,
                color: Colors.red,
              ),
              tileColor: kPrimaryLightColor,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: floatActionButtonColor,
        onPressed: () {},
        child: const Icon(Icons.fingerprint), //icon inside button
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        color: titleColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BottomAppBarOption(
              icon: Icons.exit_to_app,
              onClick: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Exit(),
                  ),
                );
              },
            ),
            BottomAppBarOption(
              icon: Icons.warning,
              onClick: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Alerts(),
                  ),
                );
              },
            ),
            BottomAppBarOption(
              icon: Icons.upload_file,
              onClick: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Exit(),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(right: 80.0),
              child: BottomAppBarOption(
                icon: Icons.edit,
                onClick: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Exit(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Alerts extends StatelessWidget {
  const Alerts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarRp(
        appBarTitle: 'Alertas',
        showImage: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: [
          Card(
            child: ListTile(
              title: const Text('Hora de Trabalhar'),
              subtitle: const Text(
                  'Avise-me quando chegar a hora de iniciar o turno de trabalho'),
              trailing: Checkbox(
                onChanged: (bool? value) {},
                value: false,
              ),
              tileColor: kPrimaryLightColor,
            ),
          ),
          const Card(
            child: ListTile(
              title: Text('Antecipar Aviso'),
              subtitle: TextField(
                decoration: InputDecoration(
                ),
              ),
              tileColor: kPrimaryLightColor,
            ),
          ),
        ],
      ),
    );
  }
}

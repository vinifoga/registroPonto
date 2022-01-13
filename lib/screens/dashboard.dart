import 'package:flutter/material.dart';
import 'package:registroponto/components/app_bar_rp.dart';

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
          //children inside bottom appbar
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
              IconButton(
                icon: const Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            IconButton(
              icon: Icon(
                Icons.warning,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.upload_file,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            Padding(
              padding: const EdgeInsets.only(right: 80.0),
              child: IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

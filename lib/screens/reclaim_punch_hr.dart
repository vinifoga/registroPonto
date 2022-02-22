import 'package:flutter/material.dart';
import 'package:registroponto/components/app_bar_rp.dart';
import 'package:registroponto/screens/punch_clocking.dart';

import '../constants.dart';

class ReclaimPunchHR extends StatelessWidget {
  const ReclaimPunchHR({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarRp(showImage: false, showBackArrow: true, appBarTitle: 'Correções',),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          GestureDetector(
            child: const Card(
              child: ListTile(
                leading: Icon(Icons.check, color: Colors.green,),
                title: Text('Vinicius Fernandes Fogaça'),
                subtitle: Text('02/09/2021 - 11:01'),
                trailing: Icon(
                  Icons.edit,
                ),
                tileColor: kPrimaryLightColor,
              ),
            ),
          ),
          GestureDetector(
            child: const Card(
              child: ListTile(
                leading: Icon(Icons.block_flipped, color: Colors.red,),
                title: Text('Jorge Matheus Silva'),
                subtitle: Text('02/09/2021 - 15:00'),
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
                    builder: (context) => PunchClocking(),
                  ),
                )
              }),
        ],
      ),
    );
  }
}



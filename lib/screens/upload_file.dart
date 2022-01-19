import 'package:flutter/material.dart';
import 'package:registroponto/components/app_bar_rp.dart';
import 'package:registroponto/constants.dart';
import 'package:registroponto/screens/punch_clocking.dart';

class UploadFile extends StatelessWidget {
  const UploadFile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarRp(appBarTitle: 'Últimos Enviados', showImage: true,),
      body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            GestureDetector(
                child: Card(
                  child: ListTile(
                    title: Text('Enviar'),
                    trailing: Icon(
                      Icons.arrow_upward,
                      color: Colors.blue,
                    ),
                    tileColor: kPrimaryLightColor,
                  ),
                ),
                onTap: () =>
                {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PunchClocking(),
                    ),
                  )
                }),
            GestureDetector(
                child: Card(
                  child: ListTile(
                    title: Text('Data: 02/05/2020'),
                    trailing: Icon(
                      Icons.remove_red_eye,
                      color: Colors.blue,
                    ),
                    tileColor: kPrimaryLightColor,
                  ),
                ),
                onTap: () =>
                {
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

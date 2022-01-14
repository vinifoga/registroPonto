import 'package:flutter/material.dart';
import 'package:registroponto/components/app_bar_rp.dart';

class Exit extends StatelessWidget {
  const Exit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarRp(appBarTitle: 'Saída', showImage: true),
      body: Text('Saída'),
    );
  }
}
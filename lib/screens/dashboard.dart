import 'package:flutter/material.dart';
import 'package:registroponto/components/app_bar_rp.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarRp(appBarTitle: 'Registro Ponto', showImage: false),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:registroponto/components/app_bar_rp.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarRp(appBarTitle: 'Erro!', showImage: true, showBackArrow: true,),
      body: Center(child: Text('Erro ao processar sua requisição, Contate o setor Responsável')),
    );
  }
}
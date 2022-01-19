import 'package:flutter/material.dart';
import 'package:registroponto/components/app_bar_rp.dart';
import 'package:registroponto/components/card_options.dart';
import 'package:registroponto/screens/punch_clocking.dart';

class MoreOptions extends StatelessWidget {
  const MoreOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarRp(
        appBarTitle: 'Registro Ponto',
        showImage: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            GestureDetector(
                child: CardOptions(text: 'Correções', icon: Icons.edit,),
                onTap: () => {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PunchClocking(),
                    ),
                  )
                }),
            GestureDetector(
                child: const CardOptions(text: 'Colaboradores', icon: Icons.work,),
                onTap: () => {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PunchClocking(),
                    ),
                  )
                }),
            GestureDetector(
                child: CardOptions(text: 'Unidades', icon: Icons.home_work_rounded),
                onTap: () => {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PunchClocking(),
                    ),
                  )
                }),
            GestureDetector(
                child: CardOptions(text: 'Usuários', icon: Icons.group),
                onTap: () => {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PunchClocking(),
                    ),
                  )
                }),
          ],
        ),
      ),
    );
  }
}

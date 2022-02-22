import 'package:flutter/material.dart';
import 'package:registroponto/components/app_bar_rp.dart';

class ReclaimPunchHR extends StatelessWidget {
  const ReclaimPunchHR({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarRp(showImage: false, showBackArrow: true, appBarTitle: 'Correções',),
    );
  }
}



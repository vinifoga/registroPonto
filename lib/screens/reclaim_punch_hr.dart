import 'dart:io';

import 'package:flutter/material.dart';
import 'package:registroponto/components/app_bar_rp.dart';
import 'package:registroponto/models/punch_clocking.dart';
import 'package:registroponto/models/user.dart';
import 'package:registroponto/screens/punch_clocking.dart';

import '../constants.dart';
import 'login_screen.dart';

class ReclaimPunchHR extends StatefulWidget {
  final List<PunchClocking> punchs;
  final String token;
  final User user;

  const ReclaimPunchHR({Key? key, required this.punchs, required this.token, required this.user}) : super(key: key);

  @override
  State<ReclaimPunchHR> createState() => _ReclaimPunchHRState();
}

class _ReclaimPunchHRState extends State<ReclaimPunchHR> {
  late List<PunchClocking> otherPunchs;

  @override
  void initState() {
    otherPunchs = widget.punchs.where((e) => e.status != 'NORMAL').toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarRp(showImage: false, showBackArrow: true, appBarTitle: 'Correções',),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: otherPunchs.length,
                itemBuilder: (context, index){
                  return GestureDetector(
                    child: Card(
                      child: ListTile(
                        leading: const Icon(Icons.hourglass_bottom),
                        title: Text(otherPunchs[index].status),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Data: ${otherPunchs[index].data}'),
                            Text('Hora: ${otherPunchs[index].hora}'),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () async {
                            await updateReclaim(otherPunchs[index]);
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      )
    );
  }

  Future<void> updateReclaim(PunchClocking punch) async {
    setState(() {

    });
  }


}



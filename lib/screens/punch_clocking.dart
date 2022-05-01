import 'package:flutter/material.dart';
import 'package:registroponto/components/app_bar_rp.dart';
import 'package:registroponto/constants.dart';
import 'package:registroponto/models/punch_clocking.dart';
import 'package:registroponto/models/user.dart';
import 'package:registroponto/screens/reclaim_punch.dart';

class PunchClockingScreen extends StatefulWidget {
  final List<PunchClocking> punchs;
  final String token;
  final User user;
  const PunchClockingScreen({Key? key, required this.punchs, required this.token, required this.user}) : super(key: key);


  @override
  State<PunchClockingScreen> createState() => _PunchClockingScreenState();
}

class _PunchClockingScreenState extends State<PunchClockingScreen> {
  late List<bool> isSelected;
  late int _index = 0;
  bool _isLoading = true;
  bool _showError = false;
  late Widget _punchPadding;


  @override
  void initState() {
    isSelected = [true, false];
    super.initState();
    _punchPadding = Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        primary: false,
        shrinkWrap: true,
        itemCount: widget.punchs.length,
        itemBuilder: (context, index){
          return Card(
            child: ListTile(
              leading: Icon(Icons.hourglass_bottom),
              title: Text(widget.punchs[index].status),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Data: ${widget.punchs[index].data}'),
                  Text('Hora: ${widget.punchs[index].hora}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarRp(appBarTitle: 'Últimas Marcações', showImage: true, showBackArrow: true,),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ToggleButtons(
                  color: kButtonColorDisable,
                  selectedColor: kButtonColorEnable,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Registros',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Correções',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                  onPressed: (int index) {
                    setState(() {
                      for (int i = 0; i < isSelected.length; i++) {
                        isSelected[i] = i == index;
                      }
                      _index = index;
                    });
                  },
                  isSelected: isSelected,
                ),
              ),
            ],
          ),
          selectedItem(_index),
        ],
      ),
      floatingActionButton: Visibility(
        visible: _index == 0 ? false : true,
        child: FloatingActionButton(
          onPressed: () => {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ReclaimPunch(token: widget.token, user: widget.user,

                ),
              ),
            ),
          },
          child: const Icon(Icons.add),
          backgroundColor: floatActionButtonColor,
        ),
      ),
    );
  }

  Column selectedItem(int index) {
    if (index == 0) {
      return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _punchPadding,
            Container(
              padding: const EdgeInsets.all(50),
              margin: const EdgeInsets.all(50),
              child: Center(
                child: _isLoading
                    ? const Text('')
                    : const CircularProgressIndicator(),
              ),
            ),
          ],
        );
    } else {
      List<PunchClocking> otherPunchs = widget.punchs.where((e) => e.status != 'NORMAL').toList();
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: otherPunchs.length,
              itemBuilder: (context, index){
                return Card(
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
                  ),
                );
              },
            ),
          ),
        ],
      );
    }
  }
}

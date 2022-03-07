import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';
import 'package:registroponto/components/app_bar_rp.dart';
import 'package:registroponto/components/input_text.dart';
import 'package:registroponto/components/rounded_button.dart';

class UserRegister extends StatefulWidget {
  final String token;

  UserRegister({Key? key, required this.token}) : super(key: key);

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  bool status = false;
  final dateFormat = DateFormat("dd-MM-yyyy");
  final hourFormat = DateFormat("HH:mm");

  final nameController = TextEditingController();
  final mailController = TextEditingController();
  final defaultPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarRp(
        showBackArrow: true,
        showImage: false,
        appBarTitle: 'Usuário',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: [
              InputText(
                labelText: 'Nome Completo',
                hintText: 'Digite o nome',
                keyboardType: TextInputType.text,
                controller: nameController,
              ),
              InputText(
                labelText: 'Email',
                hintText: 'Digite o e-mail',
                keyboardType: TextInputType.emailAddress,
                controller: mailController,
              ),
              InputText(
                labelText: 'Senha Padrão',
                hintText: 'Digite uma senha',
                keyboardType: TextInputType.text,
                controller: defaultPasswordController,
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: FlutterSwitch(
                  width: 125.0,
                  height: 35.0,
                  valueFontSize: 17.0,
                  toggleSize: 25.0,
                  value: status,
                  borderRadius: 15.0,
                  padding: 8.0,
                  showOnOff: true,
                  activeColor: Colors.greenAccent,
                  activeText: 'Ativo',
                  inactiveColor: Colors.redAccent,
                  inactiveText: 'Desligado',
                  onToggle: (val) {
                    setState(() {
                      status = val;
                    });
                  },
                ),
              ),
              RoundedButton(
                  text: "SALVAR", press: () {}, textColor: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

test(BuildContext context) {
  Picker(
    adapter: NumberPickerAdapter(data: <NumberPickerColumn>[
      const NumberPickerColumn(begin: 0, end: 999, suffix: Text(' hours')),
      const NumberPickerColumn(
          begin: 0, end: 60, suffix: Text(' minutes'), jump: 15),
    ]),
    delimiter: <PickerDelimiter>[
      PickerDelimiter(
        child: Container(
          width: 30.0,
          alignment: Alignment.center,
          child: Icon(Icons.more_vert),
        ),
      )
    ],
    hideHeader: true,
    confirmText: 'OK',
    confirmTextStyle:
        const TextStyle(inherit: false, color: Colors.red, fontSize: 22),
    title: const Text('Select duration'),
    selectedTextStyle: const TextStyle(color: Colors.blue),
    onConfirm: (Picker picker, List<int> value) {
      // You get your duration here
      Duration _duration = Duration(
          hours: picker.getSelectedValues()[0],
          minutes: picker.getSelectedValues()[1]);
    },
  ).showDialog(context);
}

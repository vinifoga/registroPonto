import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:registroponto/components/app_bar_rp.dart';
import 'package:registroponto/components/input_text.dart';
import 'package:registroponto/components/personalized_duration_picker.dart';
import 'package:registroponto/components/rounded_button.dart';
import 'package:intl/intl.dart';
import 'package:registroponto/components/select_type_reclaim_punch.dart';

class EmployeeRegister extends StatefulWidget {
  EmployeeRegister({Key? key}) : super(key: key);

  @override
  State<EmployeeRegister> createState() => _EmployeeRegisterState();
}

class _EmployeeRegisterState extends State<EmployeeRegister> {
  bool status = false;
  final dateFormat = DateFormat("dd-MM-yyyy");
  final hourFormat = DateFormat("HH:mm");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarRp(showBackArrow: true, showImage: false, appBarTitle: 'Colaborador',),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: [
              const InputText(labelText: 'Nome Completo', hintText: 'Digite o nome', keyboardType: TextInputType.text,),
              const InputText(labelText: 'Email', hintText: 'Digite o e-mail', keyboardType: TextInputType.emailAddress,),
              Padding(
                padding: const EdgeInsets.fromLTRB (16.0, 0.0, 16.0, 0.0),
                child: DateTimeField(
                  format: dateFormat,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Data de Nascimento',
                    hintText: 'Digite a data de Nascimento'
                  ),
                  onShowPicker: (context, currentValue) {
                    return showDatePicker(
                        context: context,
                        fieldLabelText: 'Data',
                        locale: const Locale('pt'),
                        firstDate: DateTime(2022),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100));
                  },

                ),
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
              const InputText(hintText: '(11) 99999-9999', labelText: 'Telefone', keyboardType: TextInputType.phone,),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: SelectType(),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 15.0, 16.0, 0.0),
                child: DateTimeField(
                  format: dateFormat,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Entrada',
                      hintText: 'Digite a data de Nascimento'
                  ),
                  onShowPicker: (context, currentValue) {
                    return showDatePicker(
                        context: context,
                        fieldLabelText: 'Data',
                        locale: const Locale('pt'),
                        firstDate: DateTime(2022),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100));
                  },

                ),
              ),
              const InputText(hintText: 'Digite o CPF', labelText: 'CPF', keyboardType: TextInputType.number,),
              const InputText(hintText: 'Digite o PIS', labelText: 'PIS', keyboardType: TextInputType.number,),
              Padding(
                padding: const EdgeInsets.fromLTRB (16.0, 0.0, 16.0, 0.0),
                child: DateTimeField(
                  format: hourFormat,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Hora Entrada',
                      hintText: 'Digite a Hora de Entrada'
                  ),
                  onShowPicker: (context, currentValue) async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(
                          currentValue ?? DateTime.now()),
                    );
                    return DateTimeField.convert(time);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB (16.0, 15.0, 16.0, 0.0),
                child: DateTimeField(
                  format: hourFormat,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Hora Saída',
                      hintText: 'Digite a Hora de Entrada'
                  ),
                  onShowPicker: (context, currentValue) async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(
                          currentValue ?? DateTime.now()),
                    );
                    return DateTimeField.convert(time);
                  },
                ),
              ),
              InputText(hintText: 'Duração', labelText: 'Intervalo', keyboardType: TextInputType.number,),
              RoundedButton(
                  text: "SALVAR",
                  press: () {

                  },
                  textColor: Colors.white),

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
      const NumberPickerColumn(begin: 0, end: 60, suffix: Text(' minutes'), jump: 15),
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
    confirmTextStyle: TextStyle(inherit: false, color: Colors.red, fontSize: 22),
    title: const Text('Select duration'),
    selectedTextStyle: TextStyle(color: Colors.blue),
    onConfirm: (Picker picker, List<int> value) {
      // You get your duration here
      Duration _duration = Duration(hours: picker.getSelectedValues()[0], minutes: picker.getSelectedValues()[1]);
    },
  ).showDialog(context);
}
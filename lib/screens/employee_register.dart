import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:registroponto/components/app_bar_rp.dart';
import 'package:registroponto/components/input_text.dart';
import 'package:registroponto/components/personalized_duration_picker.dart';
import 'package:http/http.dart' as http;
import 'package:registroponto/components/rounded_button.dart';
import 'package:intl/intl.dart';
import 'package:registroponto/components/select_type_reclaim_punch.dart';
import 'package:registroponto/models/employee.dart';
import 'package:registroponto/models/job_title.dart';
import 'package:registroponto/models/organization_unit.dart';
import 'package:registroponto/screens/employee_list.dart';

Uri urlEmployee = Uri.parse("https://registro-ponto-api.herokuapp.com/colaboradores");
late List<Employee> users = [];

class EmployeeRegister extends StatefulWidget {
  final String token;
  final List<JobTitle> jobTitles;
  final List<OrganizationUnit> units;
  const EmployeeRegister({Key? key, required this.token, required this.jobTitles, required this.units}) : super(key: key);

  @override
  State<EmployeeRegister> createState() => _EmployeeRegisterState();
}

class _EmployeeRegisterState extends State<EmployeeRegister> {
  final formKey = GlobalKey<FormState>();
  bool status = false;
  final dateFormat = DateFormat("dd-MM-yyyy");
  final hourFormat = DateFormat("HH:mm");
  bool _isLoading = false;
  bool _showError = false;
  List<String> teste = ['123', '456', '897'];

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      setState(() {
        _isLoading = true;
        _showError = false;
      });
      try {

        var responseUser = await http.post(urlEmployee, headers: {
          'Content-type': 'application/json',
          'Authorization': widget.token,
        },
        body: '');

        setState(() {
          _isLoading = false;
        });

      } catch (e) {
        print(e);
        setState(() {
          _isLoading = false;
          _showError = true;
        });
      }
    }
  }


  @override
  void initState() {
    print(jobTitles);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarRp(showBackArrow: true, showImage: false, appBarTitle: 'Colaborador',),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Form(
            key: formKey,
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
                      labelText: 'Data de Admissão',
                      hintText: 'Digite a data de Admissão'
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
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  child: SelectType(list: units.map((e) => e.descricao.toString()).toList()),
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: SelectType(list: jobTitles.map((e) => e.descricao.toString()).toList()),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 15.0, 16.0, 0.0),
                  child: DateTimeField(
                    format: dateFormat,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Data Nascimento',
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
                      const AlertDialog(
                        content: CircularProgressIndicator(
                          strokeWidth: 5,
                        ),
                      );
                      validateAndSubmit();
                    },
                    textColor: Colors.white),

              ],
            ),
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
    confirmTextStyle: const TextStyle(inherit: false, color: Colors.red, fontSize: 22),
    title: const Text('Select duration'),
    selectedTextStyle: const TextStyle(color: Colors.blue),
    onConfirm: (Picker picker, List<int> value) {
      // You get your duration here
      Duration _duration = Duration(hours: picker.getSelectedValues()[0], minutes: picker.getSelectedValues()[1]);
    },
  ).showDialog(context);
}
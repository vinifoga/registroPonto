
import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:registroponto/components/app_bar_rp.dart';
import 'package:registroponto/components/input_text.dart';
import 'package:registroponto/components/rounded_button.dart';
import 'package:registroponto/components/select_type_reclaim_punch.dart';
import 'package:registroponto/models/department.dart';
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
  final dateFormat = DateFormat("yyyy-MM-dd");
  final hourFormat = DateFormat("HH:mm:ss");
  bool _isLoading = false;
  bool _showError = false;

  final nameController = TextEditingController();
  final mailController = TextEditingController();
  final admissionDateController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final birthDateController = TextEditingController();
  final cpfController = TextEditingController();
  final pisController = TextEditingController();
  final startWorkController = TextEditingController();
  final endWorkController = TextEditingController();
  final breakTimeController = TextEditingController();

  late final jobTitleKey = GlobalKey();
  late List<String> jobTitlelist = jobTitles.map((e) => e.descricao.toString()).toList();
  late String dropdownValueJobTitle = jobTitlelist.first;

  late List<String> unitsList = units.map((e) => e.descricao.toString()).toList();
  late String dropdownValueUnit = unitsList.first;

  bool validateAndSave() {
    final form = formKey.currentState;
    final jobTitle = jobTitles.firstWhere((element) => element.descricao == dropdownValueJobTitle);
    final unit = units.firstWhere((element) => element.descricao == dropdownValueUnit);



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
        JobTitle jobTitleChoose = jobTitles.where((jobTitle) => jobTitle.descricao == dropdownValueJobTitle).first;
        OrganizationUnit unitChoose = units.where((unit) => unit.descricao == dropdownValueUnit).first;

        Map<String, String> header = {
          'Content-type': 'application/json',
          'Authorization': widget.token
        };

        final body = jsonEncode({
          "email": mailController.text,
          "nome": nameController.text,
          "dataNascimento": birthDateController.text,
          "ativo": status,
          "telefone": phoneNumberController.text,
          "cargoId": jobTitleChoose.id,
          "dataAdmissao": admissionDateController.text,
          "cpf": cpfController.text,
          "pis": pisController.text,
          "horaEntra": startWorkController.text,
          "horaSai": endWorkController.text,
          "intervaloTempo": breakTimeController.text,
          "trabalhaTodosSabados": false,
          "trabalhaSabadosAlternados": true,
          "homeOffice": false,
          "horaEntraSabado": "08:00:00",
          "horaSaiSabado": "12:00:00",
          "unidadeOrganizacionalId": unitChoose.codUnidade
        });

        var responseUser = await http.post(urlEmployee,
            headers: header,
            body: body);
        if(responseUser.statusCode == 201){
          Navigator.pop(context);
        } else {
          print(responseUser.statusCode);
          print('Erro ao cadastrar Colaborador');
        }

        setState(() {
          _isLoading = false;
        });

      } catch (e) {
        setState(() {
          _isLoading = false;
          _showError = true;
        });
      }
    }
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
                InputText(labelText: 'Nome Completo', hintText: 'Digite o nome', keyboardType: TextInputType.text, controller: nameController,),
                InputText(labelText: 'Email', hintText: 'Digite o e-mail', keyboardType: TextInputType.emailAddress, controller: mailController, ),
                Padding(
                  padding: const EdgeInsets.fromLTRB (16.0, 0.0, 16.0, 0.0),
                  child: DateTimeField(
                    controller: admissionDateController,
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
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: DropdownButton<String>(
                                value: dropdownValueUnit,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                ),
                                elevation: 16,
                                style: const TextStyle(color: Colors.black),
                                isExpanded: true,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValueUnit = newValue!;
                                  });
                                },
                                items: unitsList.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                InputText(hintText: '(11) 99999-9999', labelText: 'Telefone', keyboardType: TextInputType.phone, controller: phoneNumberController,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child:  SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: DropdownButton<String>(
                                  value: dropdownValueJobTitle,
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                  ),
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.black),
                                  isExpanded: true,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownValueJobTitle = newValue!;
                                    });
                                  },
                                  items: jobTitlelist.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 15.0, 16.0, 0.0),
                  child: DateTimeField(
                    controller: birthDateController,
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
                          firstDate: DateTime(1900),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(2100));
                    },
                  ),
                ),
                InputText(hintText: 'Digite o CPF', labelText: 'CPF', keyboardType: TextInputType.number, controller: cpfController,),
                InputText(hintText: 'Digite o PIS', labelText: 'PIS', keyboardType: TextInputType.number, controller: pisController),
                Padding(
                  padding: const EdgeInsets.fromLTRB (16.0, 0.0, 16.0, 0.0),
                  child: DateTimeField(
                    controller: startWorkController,
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
                    controller: endWorkController,
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
                Padding(
                  padding: const EdgeInsets.fromLTRB (16.0, 15.0, 16.0, 0.0),
                  child: DateTimeField(
                    controller: breakTimeController,
                    format: hourFormat,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Intervalo',
                        hintText: 'Digite o tempo de intervalo'
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
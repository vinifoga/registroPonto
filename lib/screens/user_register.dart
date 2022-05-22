import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';
import 'package:registroponto/components/app_bar_rp.dart';
import 'package:registroponto/components/input_text.dart';
import 'package:registroponto/components/rounded_button.dart';
import 'package:registroponto/models/employee.dart';
import 'package:registroponto/models/roles.dart';
import 'package:registroponto/screens/dashboard_hr_analist.dart';
import 'package:registroponto/screens/user_list.dart';
import 'package:http/http.dart' as http;

Uri urlUsers = Uri.parse("https://registro-ponto-api-v2.herokuapp.com/usuarios");

class UserRegister extends StatefulWidget {
  final String token;
  final List<Employee> employees;
  final List<Roles> roles;

  const UserRegister(
      {Key? key,
      required this.token,
      required this.employees,
      required this.roles})
      : super(key: key);

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final formKey = GlobalKey<FormState>();
  bool status = false;
  final dateFormat = DateFormat("yyyy-MM-dd");
  final hourFormat = DateFormat("HH:mm:ss");
  bool _isLoading = false;
  bool _showError = false;

  final nameController = TextEditingController();
  final mailController = TextEditingController();
  final defaultPasswordController = TextEditingController();

  late List<String> employeesList =
      widget.employees.map((e) => e.nome.toString()).toList();
  late String dropdownValueEmployee = employeesList.first;

  late List<String> rolesList =
      roles.map((e) => e.nomeRole.toString()).toList();
  late String dropdownValueRole = rolesList.first;

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
        Employee employeeChoose = widget.employees.firstWhere((e) => e.nome == dropdownValueEmployee);
        Roles roleChoose = roles.firstWhere((r) => r.nomeRole == dropdownValueRole);

        Map<String, String> header = {
          'Content-type': 'application/json',
          'Authorization': widget.token
        };

        final body = jsonEncode({
          "nome": nameController.text,
          "email": mailController.text,
          "ativo": status,
          "senha": defaultPasswordController.text,
          "colaboradorId": employeeChoose.matricula,
          "roleId": roleChoose.nomeRole,
        });

        var responseUser = await http.post(urlUsers,
            headers: header,
            body: body);
        if (responseUser.statusCode == 201) {
          Navigator.pop(context);
        } else {
          print(responseUser.statusCode);
          print('Erro ao cadastrar Usuário');
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
      appBar: const AppBarRp(
        showBackArrow: true,
        showImage: false,
        appBarTitle: 'Usuário',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Form(
            key: formKey,
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                                value: dropdownValueEmployee,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                ),
                                elevation: 16,
                                style: const TextStyle(color: Colors.black),
                                isExpanded: true,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValueEmployee = newValue!;
                                  });
                                },
                                items: employeesList
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 32.0),
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
                                value: dropdownValueRole,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                ),
                                elevation: 16,
                                style: const TextStyle(color: Colors.black),
                                isExpanded: true,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValueRole = newValue!;
                                  });
                                },
                                items: rolesList.map<DropdownMenuItem<String>>(
                                    (String value) {
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

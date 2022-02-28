
import 'package:flutter/material.dart';
import 'package:registroponto/components/app_bar_rp.dart';
import 'package:registroponto/components/card_alert_check_option.dart';
import 'package:registroponto/components/card_alert_input_option.dart';
import 'package:registroponto/components/input_text.dart';
import 'package:registroponto/components/rounded_button.dart';

class Alerts extends StatelessWidget {
  const Alerts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarRp(
        appBarTitle: 'Alertas',
        showImage: true,
        showBackArrow: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: [
          CardAlertCheckOption(
              title: 'Hora de Trabalhar',
              text:
              'Avise-me quando chegar a hora de iniciar o turno de trabalho'),
          InputText(hintText: '00:05', labelText: 'Antecipar Aviso', keyboardType: TextInputType.number,),
          CardAlertCheckOption(
              title: 'Hora Saída Intervalo',
              text: 'Avise-me quando chegar a hora de sair do intervalo'),
          InputText(hintText: '00:05', labelText: 'Antecipar Aviso', keyboardType: TextInputType.number,),
          CardAlertCheckOption(
              title: 'Hora Retorno Intervalo',
              text: 'Avise-me quando chegar a hora de voltar do intervalo'),
          InputText(hintText: '00:05', labelText: 'Antecipar Aviso', keyboardType: TextInputType.number,),
          CardAlertCheckOption(
              title: 'Hora de ir para Casa',
              text: 'Avise-me quando chegar a hora de ir para casa'),
          InputText(hintText: '00:05', labelText: 'Antecipar Aviso', keyboardType: TextInputType.number,),
          CardAlertCheckOption(
              title: 'Alarme', text: 'Agendar notificações como Alarmes'),
          CardAlertCheckOption(
              title: 'Tocar Incessantemente',
              text: 'Alarme vai tocar até ser desligado'),
          RoundedButton(
              text: "SALVAR",
              press: () {},
              textColor: Colors.white),
        ],
      ),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:registroponto/screens/welcome_screen.dart';


import 'constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(RegistroPonto());
}

class RegistroPonto extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  RegistroPonto({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registro Ponto',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot){
          if(snapshot.hasError){
            print('Erro! ${snapshot.error.toString()}');
            return const Text('Algo deu errado');
          } else if (snapshot.hasData){
            return const WelcomeScreen();
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      ),
      localizationsDelegates: const [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('es'), // Spanish
        Locale('fr'), // French
        Locale('zh'), // Chinese
        Locale('pt'), // Brazil
      ],
    );
  }
}
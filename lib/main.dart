import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ying_beauty/provider/cart_provider.dart';
import 'package:ying_beauty/ui/login/login_screen.dart';
import 'package:ying_beauty/utils/app_variables.dart';
import 'package:ying_beauty/utils/prefs.dart';
import 'package:provider/provider.dart';

// import './custom_animation.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Prefs.init();
    AppVariable.init();
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: Builder(builder: (BuildContext context) {
        return MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.green,
            // brightness: Brightness.dark,
          ),
          // ThemeData(
          //   inputDecorationTheme: const InputDecorationTheme(),
          //     buttonTheme: const ButtonThemeData(
          //         buttonColor: Color.fromARGB(255, 107, 148, 72)),
          //     appBarTheme: const AppBarTheme(
          //         backgroundColor: Color.fromARGB(255, 107, 148, 72))),
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          home: const LoginScreen(),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            FormBuilderLocalizations.delegate,
          ],
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:prueba/presentation/pages/main.dart';
import 'package:prueba/presentation/routes.dart';
import 'package:prueba/service_locator.dart';


void main() {

  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registro de Ubicaciones',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: Routes.optionsList,
      onGenerateRoute: (settings) {
        if (settings.name == Routes.optionsList) {
          return MaterialPageRoute(
            builder: (_) => const OptionsPage(),
            settings: const RouteSettings(name: Routes.optionsList),
            maintainState: false,
          );
        }
        return Routes.generateRoute(settings);
      },
    );
  }

}

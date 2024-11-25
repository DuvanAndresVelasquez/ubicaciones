import 'package:flutter/material.dart';

import '../routes.dart';



class OptionsPage extends StatelessWidget {
  const OptionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final options = [
      {'title': 'Lista de Amigos', 'route': Routes.amigoList},
      {'title': 'Lista de Ubicaciones', 'route': Routes.ubicacionList},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Opciones'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: options.length,
        itemBuilder: (context, index) {
          final option = options[index];
          return ListTile(
            title: Text(option['title']!),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pushNamed(context, option['route']!);
            },
          );
        },
      ),
    );
  }
}


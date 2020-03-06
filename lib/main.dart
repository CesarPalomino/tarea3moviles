import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tarea_dos/home/home.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'models/todo_remainder.dart';

void main() async {
  // TODO: inicializar hive y agregar el adapter
  WidgetsFlutterBinding.ensureInitialized();//Si no lo pongo marca error
  final appDirectory = await path_provider.getApplicationDocumentsDirectory();//Have init necesita esto
  Hive.init(appDirectory.path);//Inicializa el Hive
  Hive.registerAdapter(TodoRemainderAdapter());//agrega el adapter (se genero con el todo remenger g)
  await Hive.openBox("Box");//Abre la caja (no sabemos si es necesario)
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarea 2',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        primaryColor: Colors.grey[50],
      ),
      home: HomePage(),
    );
  }
}

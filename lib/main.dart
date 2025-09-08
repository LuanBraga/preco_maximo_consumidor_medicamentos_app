import 'package:flutter/material.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/app/my_app.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/app/di/injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Inicializa o GetIt para registrar as dependências
  await di.init();
  runApp(const MyApp());
}
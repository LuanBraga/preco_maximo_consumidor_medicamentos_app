import 'package:flutter/material.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/app/di/injection_container.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/features/consulta_medicamentos/presentation/pages/medicamentos_page.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/features/consulta_medicamentos/presentation/provider/medicamentos_provider.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ChangeNotifierProvider provê a instância do ViewModel para a árvore de widgets.
    return ChangeNotifierProvider(
      create: (_) => sl<MedicamentosProvider>(),
      child: MaterialApp(
        title: 'Preço de Medicamentos',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const MedicamentosPage(),
      ),
    );
  }
}
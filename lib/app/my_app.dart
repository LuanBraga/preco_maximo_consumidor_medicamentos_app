import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/consulta_medicamentos/presentation/pages/medicamentos_page.dart';
import '../features/consulta_medicamentos/presentation/provider/medicamentos_provider.dart';
import 'di/injection_container.dart' as di;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => di.sl<MedicamentosProvider>(),
      child: MaterialApp(
        title: 'Consulta Medicamentos',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const MedicamentosPage(),
      ),
    );
  }
}

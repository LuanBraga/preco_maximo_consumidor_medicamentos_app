import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/auth/presentation/pages/auth_wrapper.dart';
import '../features/auth/presentation/providers/auth_provider.dart';
import '../features/consulta_medicamentos/presentation/provider/medicamentos_provider.dart';
import 'di/injection_container.dart' as di;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.sl<MedicamentosProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.sl<AuthProvider>(),
        ),
      ],
      child: MaterialApp(
        title: 'Consulta Medicamentos',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const AuthWrapper(), // O AuthWrapper decide a tela inicial
      ),
    );
  }
}
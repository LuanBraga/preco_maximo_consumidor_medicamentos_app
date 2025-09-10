import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../consulta_medicamentos/presentation/pages/medicamentos_page.dart';
import '../providers/auth_provider.dart';
import 'login_page.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    if (authProvider.isSignedIn) {
      // Se o usuário está logado, mostra a página principal
      return const MedicamentosPage();
    } else {
      // Se não, mostra a página de login
      return const LoginPage();
    }
  }
}
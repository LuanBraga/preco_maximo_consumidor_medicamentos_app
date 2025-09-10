import 'package:flutter/material.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/features/consulta_medicamentos/presentation/provider/medicamentos_provider.dart';
import '../../../../features/auth/presentation/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class MedicamentosPage extends StatelessWidget {
  const MedicamentosPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Para obter o nome do usuário
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userName = authProvider.currentUser?.displayName ?? 'Usuário';

    return Scaffold(
      appBar: AppBar(
        title: Text('Olá, $userName'),
        actions: [
          // Botão de Logout
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sair',
            onPressed: () {
              // Chama a função de logout
              context.read<AuthProvider>().signOut();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onSubmitted: (value) {
                // Chama o provider para buscar os dados
                Provider.of<MedicamentosProvider>(context, listen: false)
                    .fetchMedicamentos(value);
              },
              decoration: const InputDecoration(
                labelText: 'Digite o nome do medicamento',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Consumer<MedicamentosProvider>(
                builder: (context, provider, child) {
                  switch (provider.state) {
                    case ViewState.loading:
                      return const Center(child: CircularProgressIndicator());
                    case ViewState.error:
                      return Center(child: Text(provider.errorMessage));
                    case ViewState.loaded:
                      return ListView.builder(
                        itemCount: provider.medicamentos.length,
                        itemBuilder: (context, index) {
                          final medicamento = provider.medicamentos[index];
                          return Card(
                            child: ListTile(
                              title: Text(medicamento.nome),
                              subtitle: Text(medicamento.apresentacao),
                              trailing: Text(
                                'R\$ ${medicamento.precoMaximo.toStringAsFixed(2)}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        },
                      );
                    case ViewState.initial:
                    default:
                      return const Center(child: Text('Digite um medicamento para iniciar a busca.'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
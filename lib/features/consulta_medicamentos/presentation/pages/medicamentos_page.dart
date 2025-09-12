import 'package:flutter/material.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/features/consulta_medicamentos/presentation/provider/medicamentos_provider.dart';
import '../../../../features/auth/presentation/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class MedicamentosPage extends StatefulWidget {
  const MedicamentosPage({super.key});

  @override
  State<MedicamentosPage> createState() => _MedicamentosPageState();
}

class _MedicamentosPageState extends State<MedicamentosPage> {
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provider = context.read<MedicamentosProvider>();
    _textController.addListener(() {
      provider.onSearchChanged(_textController.text);
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    final userName = authProvider.currentUser?.displayName ?? 'Usuário';

    return Scaffold(
      appBar: AppBar(
        title: Text('Olá, $userName'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sair',
            onPressed: () => authProvider.signOut(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Digite o nome do medicamento',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _textController.clear();
                    context.read<MedicamentosProvider>().clearSuggestions();
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Consumer<MedicamentosProvider>(
                builder: (context, provider, child) {
                  switch (provider.suggestionState) {
                    case SuggestionState.loading:
                      return const Center(child: CircularProgressIndicator());
                    case SuggestionState.error:
                      return Center(child: Text(provider.suggestionErrorMessage));
                    case SuggestionState.loaded:
                      if (provider.suggestions.isEmpty) {
                        return const Center(child: Text('Nenhum medicamento encontrado.'));
                      }
                      return ListView.builder(
                        itemCount: provider.suggestions.length,
                        itemBuilder: (context, index) {
                          final suggestion = provider.suggestions[index];
                          return Card(
                            child: ListTile(
                              title: Text(suggestion.produto),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Princípio Ativo: ${suggestion.principioAtivo}"),
                                  Text("Laboratório: ${suggestion.laboratorio}"),
                                  Text(suggestion.apresentacao),
                                ],
                              ),
                              onTap: () {
                                // Ação de clique pode ser definida aqui, como navegar para uma tela de detalhes.
                                // Por enquanto, apenas preenche o campo de texto.
                                _textController.text = suggestion.produto;
                                _textController.selection = TextSelection.fromPosition(
                                  TextPosition(offset: _textController.text.length),
                                );
                              },
                            ),
                          );
                        },
                      );
                    case SuggestionState.initial:
                    default:
                      return const Center(child: Text('Digite 3 ou mais letras para buscar.'));
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
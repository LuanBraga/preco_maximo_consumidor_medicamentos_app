import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/core/error/failures.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/features/consulta_medicamentos/domain/entities/medicamento_autocomplete.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/features/consulta_medicamentos/domain/usecases/get_autocomplete_suggestions.dart';

enum SuggestionState { initial, loading, loaded, error }

class MedicamentosProvider extends ChangeNotifier {
  final GetAutocompleteSuggestions getAutocompleteSuggestions;
  Timer? _debounce;

  MedicamentosProvider({required this.getAutocompleteSuggestions});

  SuggestionState _suggestionState = SuggestionState.initial;
  SuggestionState get suggestionState => _suggestionState;

  List<MedicamentoAutocomplete> _suggestions = [];
  List<MedicamentoAutocomplete> get suggestions => _suggestions;

  String _suggestionErrorMessage = '';
  String get suggestionErrorMessage => _suggestionErrorMessage;

  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      if (query.trim().length > 2) { // Busca apenas com mais de 2 caracteres
        fetchAutocompleteSuggestions(query);
      } else {
        clearSuggestions();
      }
    });
  }

  Future<void> fetchAutocompleteSuggestions(String termo) async {
    _suggestionState = SuggestionState.loading;
    notifyListeners();

    final result = await getAutocompleteSuggestions(AutocompleteParams(termo: termo));
    result.fold(
          (failure) {
        _suggestionErrorMessage = _mapFailureToMessage(failure);
        _suggestionState = SuggestionState.error;
      },
          (data) {
        _suggestions = data;
        _suggestionState = SuggestionState.loaded;
      },
    );
    notifyListeners();
  }

  void clearSuggestions() {
    _suggestions = [];
    _suggestionState = SuggestionState.initial;
    notifyListeners();
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure) {
      case ServerFailure():
        return 'Erro ao acessar o servidor. Tente novamente mais tarde.';
      case CacheFailure():
        return 'Erro ao acessar os dados locais.';
      case _:
        return 'Ocorreu um erro inesperado.';
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
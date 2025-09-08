import 'package:flutter/foundation.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/core/error/failures.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/features/consulta_medicamentos/domain/entities/medicamento.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/features/consulta_medicamentos/domain/usecases/get_medicamentos.dart';

enum ViewState { initial, loading, loaded, error }

class MedicamentosProvider extends ChangeNotifier {
  final GetMedicamentos getMedicamentos;

  MedicamentosProvider({required this.getMedicamentos});

  ViewState _state = ViewState.initial;
  ViewState get state => _state;

  List<Medicamento> _medicamentos = [];
  List<Medicamento> get medicamentos => _medicamentos;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<void> fetchMedicamentos(String query) async {
    _state = ViewState.loading;
    notifyListeners();

    final result = await getMedicamentos(Params(query: query));

    result.fold(
          (failure) {
        _errorMessage = _mapFailureToMessage(failure);
        _state = ViewState.error;
      },
          (data) {
        _medicamentos = data;
        _state = ViewState.loaded;
      },
    );

    notifyListeners();
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure) {
      case ServerFailure():
        return 'Erro ao acessar o servidor. Tente novamente mais tarde.';
      case CacheFailure():
        return 'Erro ao acessar os dados locais.';
      case _: // O '_' é o novo "default" para pattern matching
        return 'Ocorreu um erro inesperado.';
    }
  }
}
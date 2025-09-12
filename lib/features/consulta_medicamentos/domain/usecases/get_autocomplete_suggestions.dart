import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/core/error/failures.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/core/usecases/usecase.dart';
import '../entities/medicamento_autocomplete.dart';
import '../repositories/medicamento_repository.dart';

class GetAutocompleteSuggestions implements UseCase<List<MedicamentoAutocomplete>, AutocompleteParams> {
  final MedicamentoRepository repository;

  GetAutocompleteSuggestions(this.repository);

  @override
  Future<Either<Failure, List<MedicamentoAutocomplete>>> call(AutocompleteParams params) async {
    if (params.termo.trim().isEmpty) {
      return const Right([]);
    }
    return await repository.getAutocompleteSuggestions(params.termo);
  }
}

class AutocompleteParams extends Equatable {
  final String termo;

  const AutocompleteParams({required this.termo});

  @override
  List<Object> get props => [termo];
}
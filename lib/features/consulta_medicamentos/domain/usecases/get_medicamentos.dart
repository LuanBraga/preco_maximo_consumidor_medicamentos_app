import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/core/error/failures.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/core/usecases/usecase.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/features/consulta_medicamentos/domain/entities/medicamento.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/features/consulta_medicamentos/domain/repositories/medicamento_repository.dart';

class GetMedicamentos implements UseCase<List<Medicamento>, Params> {
  final MedicamentoRepository repository;

  GetMedicamentos(this.repository);

  @override
  Future<Either<Failure, List<Medicamento>>> call(Params params) async {
    return await repository.getMedicamentos(params.query);
  }
}

class Params extends Equatable {
  final String query;

  const Params({required this.query});

  @override
  List<Object> get props => [query];
}
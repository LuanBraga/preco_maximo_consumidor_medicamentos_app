import 'package:dartz/dartz.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/core/error/failures.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/features/consulta_medicamentos/domain/entities/medicamento.dart';

// Este é o Contrato. A camada de domínio não sabe como os dados são obtidos,
// ela apenas define o que precisa ser feito.
abstract class MedicamentoRepository {
  Future<Either<Failure, List<Medicamento>>> getMedicamentos(String query);
}
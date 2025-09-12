import 'package:dartz/dartz.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/core/error/exceptions.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/core/error/failures.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/features/consulta_medicamentos/data/datasources/medicamento_remote_data_source.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/features/consulta_medicamentos/domain/entities/medicamento_autocomplete.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/features/consulta_medicamentos/domain/repositories/medicamento_repository.dart';

class MedicamentoRepositoryImpl implements MedicamentoRepository {
  final MedicamentoRemoteDataSource remoteDataSource;

  MedicamentoRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<MedicamentoAutocomplete>>> getAutocompleteSuggestions(String termo) async {
    try {
      final suggestions = await remoteDataSource.getAutocompleteSuggestions(termo);
      return Right(suggestions);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
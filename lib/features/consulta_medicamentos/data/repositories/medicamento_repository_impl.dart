import 'package:dartz/dartz.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/core/error/exceptions.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/core/error/failures.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/features/consulta_medicamentos/data/datasources/medicamento_remote_data_source.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/features/consulta_medicamentos/domain/entities/medicamento.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/features/consulta_medicamentos/domain/repositories/medicamento_repository.dart';

class MedicamentoRepositoryImpl implements MedicamentoRepository {
  final MedicamentoRemoteDataSource remoteDataSource;
  // Você poderia adicionar um localDataSource aqui para cache

  MedicamentoRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<Medicamento>>> getMedicamentos(String query) async {
    try {
      final remoteMedicamentos = await remoteDataSource.getMedicamentos(query);
      return Right(remoteMedicamentos);
    } on ServerException {
      return Left(ServerFailure());
    }
    // Adicione aqui a verificação de conexão com a internet se desejar
  }
}
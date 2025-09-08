import 'package:equatable/equatable.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';

// O Either é do pacote dartz. Ele é usado para tratamento funcional de erros.
// Ele retorna um Failure (esquerda) ou o tipo de sucesso (direita).
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

// Classe para ser usada quando um use case não precisar de parâmetros
class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
import 'package:equatable/equatable.dart';

class Medicamento extends Equatable {
  final String nome;
  final String apresentacao;
  final double precoMaximo;

  const Medicamento({
    required this.nome,
    required this.apresentacao,
    required this.precoMaximo,
  });

  @override
  List<Object?> get props => [nome, apresentacao, precoMaximo];
}
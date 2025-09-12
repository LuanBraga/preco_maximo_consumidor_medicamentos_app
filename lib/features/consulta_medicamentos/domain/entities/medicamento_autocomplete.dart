import 'package:equatable/equatable.dart';

class MedicamentoAutocomplete extends Equatable {
  final String id;
  final String produto;
  final String principioAtivo;
  final String apresentacao;
  final String laboratorio;

  const MedicamentoAutocomplete({
    required this.id,
    required this.produto,
    required this.principioAtivo,
    required this.apresentacao,
    required this.laboratorio,
  });

  @override
  List<Object?> get props => [id, produto, principioAtivo, apresentacao, laboratorio];
}
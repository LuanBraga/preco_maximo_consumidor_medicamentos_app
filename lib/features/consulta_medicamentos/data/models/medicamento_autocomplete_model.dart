import '../../domain/entities/medicamento_autocomplete.dart';

class MedicamentoAutocompleteModel extends MedicamentoAutocomplete {
  const MedicamentoAutocompleteModel({
    required super.id,
    required super.produto,
    required super.principioAtivo,
    required super.apresentacao,
    required super.laboratorio,
  });

  factory MedicamentoAutocompleteModel.fromJson(Map<String, dynamic> json) {
    return MedicamentoAutocompleteModel(
      id: json['id'] as String? ?? 'id não informado',
      produto: json['produto'] as String? ?? 'produto não informado',
      principioAtivo: json['principioAtivo'] as String? ?? 'principio ativo não informado',
      apresentacao: json['apresentacao'] as String? ?? 'apresentacao não informada',
      laboratorio: json['laboratorio'] as String? ?? 'Laboratorio não informado',
    );
  }
}
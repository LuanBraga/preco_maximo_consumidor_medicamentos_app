import 'package:preco_maximo_consumidor_medicamentos_app/features/consulta_medicamentos/domain/entities/medicamento.dart';

class MedicamentoModel extends Medicamento {
  const MedicamentoModel({
    required super.nome,
    required super.apresentacao,
    required super.precoMaximo,
  });

  factory MedicamentoModel.fromJson(Map<String, dynamic> json) {
    return MedicamentoModel(
      nome: json['nome'] ?? 'Nome não informado',
      apresentacao: json['apresentacao'] ?? 'Apresentação não informada',
      precoMaximo: (json['preco_maximo'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'apresentacao': apresentacao,
      'preco_maximo': precoMaximo,
    };
  }
}
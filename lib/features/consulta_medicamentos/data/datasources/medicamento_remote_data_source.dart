import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:preco_maximo_consumidor_medicamentos_app/core/error/exceptions.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/features/consulta_medicamentos/data/models/medicamento_model.dart';

abstract class MedicamentoRemoteDataSource {
  Future<List<MedicamentoModel>> getMedicamentos(String query);
}

class MedicamentoRemoteDataSourceImpl implements MedicamentoRemoteDataSource {
  final http.Client client;

  MedicamentoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MedicamentoModel>> getMedicamentos(String query) async {
    // URL DA API
    final response = await client.get(
      Uri.parse('https://sua-api.com/medicamentos?search=$query'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => MedicamentoModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }
}
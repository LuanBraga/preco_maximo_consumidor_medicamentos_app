import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/network/api_constants.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/core/error/exceptions.dart';
import '../models/medicamento_autocomplete_model.dart';

abstract class MedicamentoRemoteDataSource {
  Future<List<MedicamentoAutocompleteModel>> getAutocompleteSuggestions(String termo);
}

class MedicamentoRemoteDataSourceImpl implements MedicamentoRemoteDataSource {
  final http.Client client;

  MedicamentoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MedicamentoAutocompleteModel>> getAutocompleteSuggestions(String termo) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}/api/autocomplete-medicamento').replace(queryParameters: {
      'termo': termo,
      'page': '0',
      'size': '10',
    });

    final response = await client.get(uri, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<dynamic> content = jsonResponse['content'] ?? [];
      return content.map((json) => MedicamentoAutocompleteModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }
}
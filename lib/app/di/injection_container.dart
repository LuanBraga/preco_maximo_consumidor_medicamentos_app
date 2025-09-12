import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:preco_maximo_consumidor_medicamentos_app/features/consulta_medicamentos/data/datasources/medicamento_remote_data_source.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/features/consulta_medicamentos/data/repositories/medicamento_repository_impl.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/features/consulta_medicamentos/domain/repositories/medicamento_repository.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/features/consulta_medicamentos/domain/usecases/get_autocomplete_suggestions.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/features/consulta_medicamentos/presentation/provider/medicamentos_provider.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/features/auth/data/datasources/google_sign_in_data_source.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/features/auth/presentation/providers/auth_provider.dart';

// Instância do Service Locator
final sl = GetIt.instance;

Future<void> init() async {
  // ############################################
  // # Features - Consulta Medicamentos
  // ############################################

  // Provider (ViewModel)
  sl.registerFactory(
        () => MedicamentosProvider(getAutocompleteSuggestions: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetAutocompleteSuggestions(sl()));

  // Repository
  sl.registerLazySingleton<MedicamentoRepository>(
        () => MedicamentoRepositoryImpl(remoteDataSource: sl()),
  );

  // Data Sources
  sl.registerLazySingleton<MedicamentoRemoteDataSource>(
        () => MedicamentoRemoteDataSourceImpl(client: sl()),
  );

  // Auth Feature
  sl.registerFactory(() => AuthProvider(sl()));
  sl.registerLazySingleton<GoogleSignInDataSource>(() => GoogleSignInDataSourceImpl());

  // ############################################
  // # Externals
  // ############################################
  sl.registerLazySingleton(() => http.Client());
}
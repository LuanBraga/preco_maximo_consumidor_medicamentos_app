import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:preco_maximo_consumidor_medicamentos_app/features/consulta_medicamentos/data/datasources/medicamento_remote_data_source.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/features/consulta_medicamentos/data/repositories/medicamento_repository_impl.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/features/consulta_medicamentos/domain/repositories/medicamento_repository.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/features/consulta_medicamentos/domain/usecases/get_medicamentos.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/features/consulta_medicamentos/presentation/provider/medicamentos_provider.dart';

// Instância do Service Locator
final sl = GetIt.instance;

Future<void> init() async {
  // ############################################
  // # Features - Consulta Medicamentos
  // ############################################

  // Provider (ViewModel)
  // O Factory sempre cria uma nova instância quando solicitado.
  sl.registerFactory(
        () => MedicamentosProvider(getMedicamentos: sl()),
  );

  // Use Cases
  // O LazySingleton é instanciado apenas na primeira vez que é chamado.
  sl.registerLazySingleton(() => GetMedicamentos(sl()));

  // Repository
  sl.registerLazySingleton<MedicamentoRepository>(
        () => MedicamentoRepositoryImpl(remoteDataSource: sl()),
  );

  // Data Sources
  sl.registerLazySingleton<MedicamentoRemoteDataSource>(
        () => MedicamentoRemoteDataSourceImpl(client: sl()),
  );

  // ############################################
  // # Externals
  // ############################################
  sl.registerLazySingleton(() => http.Client());
}
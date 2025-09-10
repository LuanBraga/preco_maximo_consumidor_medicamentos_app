import 'dart:io' show Platform;

class ApiConstants {
  static String get baseUrl {
    if (Platform.isAndroid) {
      // Para o emulador Android, use 10.0.2.2 para acessar o localhost do seu computador.
      return 'http://10.0.2.2:8080'; // Substitua 8080 pela porta da sua API
    } else {
      // Para iOS, web e desktop, 'localhost' funciona diretamente.
      return 'http://localhost:8080'; // Substitua 8080 pela porta da sua API
    }
  }
}
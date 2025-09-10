import 'package:google_sign_in/google_sign_in.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/core/logger.dart';

abstract class GoogleSignInDataSource {
  /// Stream que notifica sobre mudanças no usuário.
  Stream<GoogleSignInAccount?> get onCurrentUserChanged;

  /// Tenta logar o usuário silenciosamente ao iniciar o app.
  Future<void> signInSilently();

  /// Inicia o fluxo de login interativo.
  Future<GoogleSignInAccount?> signIn();

  /// Desconecta o usuário.
  Future<void> signOut();
}

class GoogleSignInDataSourceImpl implements GoogleSignInDataSource {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Expõe o stream do pacote google_sign_in
  @override
  Stream<GoogleSignInAccount?> get onCurrentUserChanged => _googleSignIn.onCurrentUserChanged;

  // Implementa o método de login silencioso
  @override
  Future<void> signInSilently() async {
    try {
      await _googleSignIn.signInSilently();
    } catch (error, stackTrace) {
      logger.e('Erro no login silencioso', error: error, stackTrace: stackTrace);
    }
  }

  @override
  Future<GoogleSignInAccount?> signIn() async {
    try {
      return await _googleSignIn.signIn();
    } catch (error, stackTrace) {
      logger.e('Erro no login interativo', error: error, stackTrace: stackTrace);      return null;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
    } catch (error, stackTrace) {
      logger.e('Erro ao fazer logout', error: error, stackTrace: stackTrace);    }
  }
}
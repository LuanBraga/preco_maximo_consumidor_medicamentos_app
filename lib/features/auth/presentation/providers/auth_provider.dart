import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../data/datasources/google_sign_in_data_source.dart';

class AuthProvider with ChangeNotifier {
  final GoogleSignInDataSource _googleSignInDataSource;

  AuthProvider(this._googleSignInDataSource) {
    // Verifica se o usuário já estava logado ao iniciar o app
    _googleSignIn.onCurrentUserChanged.listen((account) {
      _currentUser = account;
      notifyListeners();
    });
    _googleSignIn.signInSilently();
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  GoogleSignInAccount? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isSignedIn => _currentUser != null;

  Future<void> signInWithGoogle() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final user = await _googleSignInDataSource.signIn();
      if (user != null) {
        // Linha crucial: Atualiza o usuário imediatamente
        _currentUser = user;
      } else {
        _errorMessage = 'Login com Google cancelado.';
      }
    } catch (error) {
      _errorMessage = 'Ocorreu um erro ao tentar fazer login.';
      print(error); // Ajuda a depurar o erro, se houver
    } finally {
      _isLoading = false;
      // Notifica os widgets sobre todas as mudanças (usuário, loading, erro)
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _googleSignInDataSource.signOut();
    _currentUser = null; // Limpa o usuário atual
    notifyListeners(); // Notifica a UI para reconstruir
  }
}
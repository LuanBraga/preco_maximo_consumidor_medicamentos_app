import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../data/datasources/google_sign_in_data_source.dart';
import 'package:preco_maximo_consumidor_medicamentos_app/core/logger.dart';

class AuthProvider with ChangeNotifier {
  final GoogleSignInDataSource _googleSignInDataSource;

  GoogleSignInAccount? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  AuthProvider(this._googleSignInDataSource) {
    _googleSignInDataSource.onCurrentUserChanged.listen((account) {
      _currentUser = account;
      notifyListeners();
    });
    _googleSignInDataSource.signInSilently();
  }

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
        _currentUser = user;
      } else {
        _errorMessage = 'Login com Google cancelado.';
      }
    } catch (error, stackTrace) {
      _errorMessage = 'Ocorreu um erro ao tentar fazer login.';
      logger.e(_errorMessage, error: error, stackTrace: stackTrace);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _googleSignInDataSource.signOut();
    _currentUser = null;
    notifyListeners();
  }
}
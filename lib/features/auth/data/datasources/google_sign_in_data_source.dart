import 'package:google_sign_in/google_sign_in.dart';

abstract class GoogleSignInDataSource {
  Future<GoogleSignInAccount?> signIn();
  Future<void> signOut();
}

class GoogleSignInDataSourceImpl implements GoogleSignInDataSource {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Future<GoogleSignInAccount?> signIn() async {
    try {
      return await _googleSignIn.signIn();
    } catch (error) {
      print(error);
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
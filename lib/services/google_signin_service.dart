import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;


class GoogleSignInService {

  static GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email'
    ],
  );


  static Future<GoogleSignInAccount> signInWithGoogle() async {

    try {

      final GoogleSignInAccount account = await _googleSignIn.signIn();
      final googleKey = await account.authentication;

      // print(account);
      // print('======== ID TOKEN ========= ');
      // print( googleKey.idToken );


      // TODO: Llamar un servicio REST a nuestro backend
      
      final signInWithGoogleEndpoint = Uri(
        scheme: 'https',
        host: 'apple-google-sign-in.herokuapp.com',
        path: '/google'
      );

      final session = await http.post(
        signInWithGoogleEndpoint,
        body: {
          'token': googleKey.idToken
        }
      );

      print('====== backend =======');
      print( session.body );


      return account;

      
    } catch (e) {
      print('Error en google Signin');
      print(e);
      return null;
    }

  }

  static Future signOut() async {
    await _googleSignIn.signOut();
  }

}
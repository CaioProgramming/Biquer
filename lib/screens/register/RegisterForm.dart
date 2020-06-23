import 'package:Biquer/components/PageTitle.dart';
import 'package:Biquer/constants.dart';
import 'package:Biquer/model/BiquerData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  String _password;

  String get password => _password;

  set password(String password) {
    _password = password;
  }

  String _passwordCheck;

  String get passwordCheck => _passwordCheck;

  set passwordCheck(String passwordCheck) {
    _passwordCheck = passwordCheck;
  }

  String _userName;

  String get userName => _userName;

  set userName(String userName) {
    _userName = userName;
  }

  String _userEmail;

  String get userEmail => _userEmail;

  set userEmail(String userEmail) {
    _userEmail = userEmail;
  }

  Future signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    Provider.of<BiquerData>(context, listen: true).setUser(currentUser);
  }

  Future registerWithEmailAndPassword(BuildContext context) async {
    AuthResult authResult = await _auth.createUserWithEmailAndPassword(
        email: _userEmail, password: _password);
    FirebaseUser newUser = authResult.user;
    newUser.sendEmailVerification().then((value) {}, onError: (error) {
      SnackBar snackBar = SnackBar(
          content: Text(
        'Não conseguimos validar o seu email, tente novamente!',
      ));
      Scaffold.of(context).showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    BiquerData _biquerData = Provider.of<BiquerData>(context);

    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PageTitle(
                _biquerData.user == null
                    ? 'Cadastro'
                    : 'Muito bem ${_biquerData.user.displayName}',
                _biquerData.user == null
                    ? kRegistermessage
                    : 'Seu cadastro já foi concluído prossiga com o cadastro.'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                readOnly: _biquerData.user != null,
                textInputAction: TextInputAction.next,
                onChanged: (newText) => userName = newText,
                onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                decoration: InputDecoration(
                    hintText: _biquerData.user == null
                        ? 'Nome Completo'
                        : _biquerData.user.displayName,
                    hintStyle: TextStyle(color: Theme.of(context).hintColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                readOnly: _biquerData.user != null,
                textInputAction: TextInputAction.next,
                onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                onChanged: (newText) => userEmail = newText,
                decoration: InputDecoration(
                    hintText: _biquerData.user == null
                        ? 'E-mail'
                        : _biquerData.user.email,
                    hintStyle: TextStyle(color: Theme.of(context).hintColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    )),
              ),
            ),
            Visibility(
              visible: _biquerData.user == null,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  textInputAction: TextInputAction.next,
                  onChanged: (newText) => password = newText,
                  onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Senha',
                      hintStyle: TextStyle(color: Theme.of(context).hintColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      )),
                ),
              ),
            ),
            Visibility(
              visible: _biquerData.user == null,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  textInputAction: TextInputAction.go,
                  onChanged: (newText) => passwordCheck = newText,
                  onSubmitted: (_) => () {
                    print('Register complete!');
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Confirmar senha',
                      hintStyle: TextStyle(color: Theme.of(context).hintColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      )),
                ),
              ),
            ),
          ],
        ),
        Visibility(
          visible: _biquerData.user == null,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Ou',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blue,
                  child: IconButton(
                    icon: Icon(
                      FlutterIcons.logo_google_ion,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      signInWithGoogle(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

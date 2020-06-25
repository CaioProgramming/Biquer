import 'package:Biquer/components/PageTitle.dart';
import 'package:Biquer/constants.dart';
import 'package:Biquer/model/RegisterData.dart';
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
    Provider.of<RegisterData>(context, listen: true).user = user;
  }

  Future registerWithEmailAndPassword(BuildContext context) async {
    AuthResult authResult = await _auth.createUserWithEmailAndPassword(
        email: _userEmail, password: _password);
    FirebaseUser newUser = authResult.user;
    newUser.sendEmailVerification().then((value) {
      SnackBar snackBar = SnackBar(
          content: Text(
        'Enviamos um e-mail de confirmação para você!',
      ));
      Scaffold.of(context).showSnackBar(snackBar);
    }, onError: (error) {
      SnackBar snackBar = SnackBar(
          content: Text(
        'Não conseguimos validar o seu email, tente novamente!',
      ));
      Scaffold.of(context).showSnackBar(snackBar);
    });
    Provider.of<RegisterData>(context, listen: true).user = newUser;
  }

  @override
  Widget build(BuildContext context) {
    RegisterData _biquerData = Provider.of<RegisterData>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              PageTitle(
                  _biquerData.user == null
                      ? 'Cadastro'
                      : 'Muito bem ${_biquerData.user.displayName}',
                  _biquerData.user == null
                      ? kRegistermessage
                      : 'Seu email foi validado prossiga para concluir o cadastro!'),
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
                        hintStyle:
                            TextStyle(color: Theme.of(context).hintColor),
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
                        hintStyle:
                            TextStyle(color: Theme.of(context).hintColor),
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      onPressed: () {
                        signInWithGoogle(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Registrar-se'.toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: _biquerData.user == null,
                child: Column(
                  children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                              width: 100,
                              child: Divider(
                                color: Theme.of(context).hintColor,
                              )),
                          Text(
                            'Ou Cadastre-se com',
                            style: TextStyle(fontWeight: FontWeight.w100),
                          ),
                          SizedBox(
                              width: 100,
                              child: Divider(
                                color: Theme.of(context).hintColor,
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4),
                      child: Wrap(
                        children: [
                          SocialLoginButton(
                            'Google',
                            AntDesign.googleplus,
                            onTap: () => signInWithGoogle(context),
                            backColor: Colors.red,
                            textStyle: ThemeData.dark().textTheme.bodyText1,
                            iconColor: Colors.white,
                          ),
                          SocialLoginButton(
                            'Facebook',
                            AntDesign.facebook_square,
                            onTap: () => signInWithGoogle(context),
                            backColor: Colors.blue.shade700,
                            iconColor: Colors.white,
                            textStyle: ThemeData.dark().textTheme.bodyText1,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SocialLoginButton extends StatelessWidget {
  final Function onTap;

  SocialLoginButton(this.title, this.icon,
      {@required this.onTap,
      this.backColor,
      this.iconColor,
      this.textStyle,
      this.borderColor});

  final String title;
  final IconData icon;
  final Color backColor, iconColor, borderColor;
  final TextStyle textStyle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        decoration: BoxDecoration(
            color: backColor ?? Theme.of(context).accentColor,
            border: Border.all(color: borderColor ?? Colors.transparent),
            borderRadius: BorderRadius.circular(14)),
        child: InkWell(
          onTap: onTap,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: iconColor ?? Theme.of(context).textTheme.bodyText1.color,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  title,
                  style: textStyle ??
                      Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

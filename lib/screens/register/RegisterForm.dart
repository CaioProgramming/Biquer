import 'package:Biquer/components/BaseForm.dart';
import 'package:Biquer/components/CenteredTitle.dart';
import 'package:Biquer/components/SocialLoginButton.dart';
import 'package:Biquer/constants.dart';
import 'package:Biquer/model/RegisterData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    updateState();
  }

  String _userName;

  String get userName => _userName;

  set userName(String userName) {
    _userName = userName;
    updateState();
  }

  void updateState() {
    setState(() {});
  }

  String _userEmail;

  String get userEmail => _userEmail;

  bool enableButton() =>
      _userEmail != null &&
      userEmail.isNotEmpty &&
      _userName != null &&
      userName.isNotEmpty &&
      _password != null &&
      _password.isNotEmpty;
  set userEmail(String userEmail) {
    _userEmail = userEmail;
    updateState();
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
    try {
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
    } on PlatformException catch (e) {
      print(e.code);
      SnackBar snackBar = SnackBar(
          content: Text(
        'Ocorreu um erro(${e.message})',
      ));
      Scaffold.of(context).showSnackBar(snackBar);
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    RegisterData _biquerData = Provider.of<RegisterData>(context);

    return BaseForm(!_biquerData.userLogged()
        ? [
            SvgPicture.asset(
              'images/toucan.svg',
              width: 200,
              height: 200,
            ),
            CenteredTitle(
              title: 'Cadastro',
              subtitle: kRegistermessage,
              textColor: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w200),
                onChanged: (newText) {
                  setState(() {
                    userName = newText;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Nome completo',
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.50)),
                  isDense: false,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          BorderSide(style: BorderStyle.none, width: 0)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w200),
                onChanged: (newText) {
                  setState(() {
                    userEmail = newText;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.50)),
                  isDense: false,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          BorderSide(style: BorderStyle.none, width: 0)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w200),
                onChanged: (newText) {
                  setState(() {
                    password = newText;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Senha',
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.50)),
                  isDense: false,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          BorderSide(style: BorderStyle.none, width: 0)),
                ),
              ),
            ),
            Container(
              margin: kDefaultMargin,
              child: MaterialButton(
                color: Colors.black,
                disabledColor: Colors.grey,
                shape: RoundedRectangleBorder(borderRadius: kDefaultBorder),
                padding: EdgeInsets.all(0),
                onPressed: enableButton()
                    ? () {
                        registerWithEmailAndPassword(context);
                      }
                    : null,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Registrar-se'.toUpperCase(),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
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
                  SocialLoginButton(
                    'Google',
                    AntDesign.googleplus,
                    onTap: () => signInWithGoogle(context),
                    backColor: Colors.red,
                    textStyle: ThemeData.dark()
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.white),
                    iconColor: Colors.white,
                  ),
                ],
              ),
            ),
          ]
        : [
            CenteredTitle(
                title: 'Bem-vindo ${_biquerData.user.displayName}',
                subtitle:
                    'Seu email foi validado prossiga para concluir o cadastro!',
                textColor: Colors.white)
          ]);
  }

  void moveToNextInput(BuildContext context) {
    FocusScope.of(context).nextFocus();
  }
}

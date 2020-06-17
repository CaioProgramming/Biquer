import 'package:biquerapp/constants.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Widget currentForm = SelfieForm();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 1,
          title: Text(
            'Cadastro',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w200,
            ),
            textAlign: TextAlign.center,
          ),
          centerTitle: true),
      body: currentForm,
    );
  }
}

class RegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(4),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Antes de começar a anunciar seus serviços, precisamos que realize o cadastro, ok? 😉',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                textInputAction: TextInputAction.next,
                onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                decoration: InputDecoration(
                    hintText: 'Nome Completo',
                    hintStyle: TextStyle(color: Theme.of(context).hintColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                textInputAction: TextInputAction.next,
                onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                decoration: InputDecoration(
                    hintText: 'E-mail',
                    hintStyle: TextStyle(color: Theme.of(context).hintColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                textInputAction: TextInputAction.next,
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                textInputAction: TextInputAction.go,
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Ou',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Text(
              'Cadastre-se com sua conta google',
              style:
                  TextStyle(color: Theme.of(context).hintColor, fontSize: 10),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.blue,
                child: IconButton(
                  icon: Icon(
                    MaterialCommunityIcons.google,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: MaterialButton(
                focusColor: Theme.of(context).accentColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                focusElevation: 1,
                elevation: 0,
                onPressed: () {},
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Continuar',
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 20),
                        ),
                        Icon(
                          AntDesign.arrowright,
                          color: Colors.white,
                        )
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DocumentForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(4),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                kDocumentMessage,
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.phone,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ], // Only numbers can be entered
                decoration: InputDecoration(
                    hintText: 'Número do documento(CPF, RG ou CNPJ)',
                    hintStyle: TextStyle(color: Theme.of(context).hintColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: kFileInputDecoration,
                alignment: Alignment.center,
                height: 150,
                padding: EdgeInsets.all(16),
                child: Icon(FontAwesome.file_image_o),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: kFileInputDecoration,
                alignment: Alignment.center,
                height: 150,
                padding: EdgeInsets.all(16),
                child: Icon(FontAwesome.file_image_o),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: MaterialButton(
                focusColor: Theme.of(context).accentColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                focusElevation: 1,
                elevation: 0,
                onPressed: () {},
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Continuar',
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 20),
                        ),
                        Icon(
                          AntDesign.arrowright,
                          color: Colors.white,
                        )
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SelfieForm extends StatefulWidget {
  @override
  _SelfieFormState createState() => _SelfieFormState();
}

class _SelfieFormState extends State<SelfieForm> {
  CameraController controller;
  List<CameraDescription> cameras;

  @override
  void initState() {
    super.initState();
    availableCameras().then((value) {
      cameras = value;
      controller = CameraController(cameras[1], ResolutionPreset.medium);
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(4),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                kSelfieMessage,
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: kFileInputDecoration,
                alignment: Alignment.center,
                child: cameras != null
                    ? AspectRatio(
                        aspectRatio: 3 / 4, child: CameraPreview(controller))
                    : CircularProgressIndicator(
                        strokeWidth: 1,
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: MaterialButton(
                focusColor: Theme.of(context).accentColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                focusElevation: 1,
                hoverElevation: 1,
                hoverColor: Colors.white30,
                elevation: 0,
                onPressed: () {},
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Concluir',
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 20),
                        ),
                        Icon(
                          AntDesign.check,
                          color: Colors.white,
                        )
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

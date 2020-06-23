import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'constants.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  PageController controller = PageController(initialPage: 0);
  int currentpage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: currentpage == 0
            ? null
            : IconButton(
                icon: Icon(AntDesign.arrowleft),
                onPressed: () {
                  controller.previousPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn);
                },
              ),
      ),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            PageView(
              controller: controller,
              onPageChanged: (index) {
                currentpage = index;
                setState(() {});
              },
              physics: NeverScrollableScrollPhysics(),
              children: [
                RegisterForm(),
                DocumentForm(),
                SelfieForm(pageController: controller)
              ],
            ),
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  controller.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn);
                },
                child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        gradient: currentpage < 2
                            ? kButtonGradient
                            : kSuccessButtonGradient),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          currentpage < 2 ? 'Continuar' : 'Concluir',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: Colors.white),
                        ),
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

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PageTitle('Cadastro',
                'Cadastre-se para começar a divulgar seus serviços!'),
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
          ],
        ),
        Column(
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
                    MaterialCommunityIcons.google,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class DocumentForm extends StatefulWidget {
  @override
  _DocumentFormState createState() => _DocumentFormState();
}

class _DocumentFormState extends State<DocumentForm> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(4),
        child: Column(
          children: [
            PageTitle('Documentos', kDocumentMessage),
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
          ],
        ),
      ),
    );
  }
}

class SelfieForm extends StatefulWidget {
  final PageController pageController;

  const SelfieForm({@required this.pageController});
  @override
  _SelfieFormState createState() => _SelfieFormState();
}

class _SelfieFormState extends State<SelfieForm> {
  CameraController controller;
  List<CameraDescription> cameras;
  String imageurl;
  @override
  void initState() {
    super.initState();
    availableCameras().then((value) {
      cameras = value;
      controller = CameraController(cameras[1], ResolutionPreset.max);
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void showPicture(String path) {
    imageurl = path;
    setState(() {});
  }

  void closeCamera() {
    widget.pageController.previousPage(
        duration: Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  void resetImage() {
    final dir = Directory(imageurl);
    dir.deleteSync(recursive: true);
    imageurl = null;
    print('Image reseted ');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        imageurl == null
            ? Container(
                child: cameras != null
                    ? AspectRatio(
                        aspectRatio: 3 / 4, child: CameraPreview(controller))
                    : CircularProgressIndicator(
                        strokeWidth: 3,
                      ),
              )
            : FadeInImage(
                placeholder: AssetImage('toucan.svg'),
                image: FileImage(
                  File(imageurl),
                ),
              ),
        Column(
          children: [
            Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: PageTitle('Reconhecimento facial',
                  'Tire uma foto sua com seus documentos para concluir o cadastro!'),
            ),
          ],
        ),
        CameraButtons(
          controller,
          imageurl,
          onClose: closeCamera,
          onPictureTake: (newPath) => showPicture(newPath),
          resetImage: this.resetImage,
        ),
      ],
    );
  }
}

class PageTitle extends StatelessWidget {
  final String title, message;

  const PageTitle(this.title, this.message);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 40),
          ),
          Text(
            message,
          ),
        ],
      ),
    );
  }
}

class CameraButtons extends StatelessWidget {
  Function onClose, onPictureTake, resetImage;
  CameraController controller;
  final String imagepath;

  CameraButtons(this.controller, this.imagepath,
      {this.onClose, this.onPictureTake, this.resetImage});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 75,
      left: 10,
      right: 10,
      child: Container(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: onClose,
              child: CircleAvatar(
                backgroundColor: Theme.of(context).backgroundColor,
                radius: 27,
                child: CircleAvatar(
                  child: Icon(
                    MaterialCommunityIcons.close,
                    color: Theme.of(context).backgroundColor,
                  ),
                  backgroundColor:
                      Theme.of(context).primaryTextTheme.bodyText1.color,
                  radius: 24,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                imagepath == null
                    ? takePicture(context, controller)
                    : resetImage();
              },
              child: CircleAvatar(
                backgroundColor: Theme.of(context).backgroundColor,
                radius: 27,
                child: CircleAvatar(
                  child: imagepath == null
                      ? null
                      : Icon(
                          MaterialCommunityIcons.close,
                          color: Theme.of(context).backgroundColor,
                        ),
                  backgroundColor:
                      Theme.of(context).primaryTextTheme.bodyText1.color,
                  radius: 24,
                ),
              ),
            ),
            GestureDetector(
              child: CircleAvatar(
                backgroundColor: Theme.of(context).backgroundColor,
                radius: 27,
                child: CircleAvatar(
                  child: Icon(
                    MaterialCommunityIcons.camera_rear,
                    color: Theme.of(context).backgroundColor,
                  ),
                  backgroundColor:
                      Theme.of(context).primaryTextTheme.bodyText1.color,
                  radius: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void takePicture(BuildContext context, CameraController controller) async {
    // Construct the path where the image should be saved using the
    // pattern package.
    print('Taking picture...');
    final path = join(
      // Store the picture in the temp directory.
      // Find the temp directory using the `path_provider` plugin.
      (await getTemporaryDirectory()).path,
      '${DateTime.now()}.png',
    );
    print('path saved $path');

    // Attempt to take a picture and log where it's been saved.
    await controller.takePicture(path);
    print('picture saved');
    onPictureTake(path);
  }
}

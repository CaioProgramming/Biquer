import 'dart:io';

import 'package:Biquer/components/BaseForm.dart';
import 'package:Biquer/components/CameraButtons.dart';
import 'package:Biquer/components/PageTitle.dart';
import 'package:Biquer/model/RegisterData.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

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
    initializeCamera();
  }

  void initializeCamera() async {
    imageurl = null;

    availableCameras().then((value) {
      cameras = value;
      controller = CameraController(cameras[1], ResolutionPreset.max);
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void showPicture(String path) async {
    RegisterData registerData =
        Provider.of<RegisterData>(context, listen: true);
    registerData.userPicURL = path;
    setState(() {
      imageurl = path;
    });
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

  Widget preview() {
    if (imageurl != null) {
      return FadeInImage(
        placeholder: AssetImage('assets/images/toucan.svg'),
        image: FileImage(
          File(imageurl),
        ),
      );
    }
    if (cameras != null && imageurl == null) {
      return AspectRatio(
          aspectRatio: 3 / 4.3, child: CameraPreview(controller));
    }
    return CupertinoActivityIndicator();
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      [
        PageTitle('Reconhecimento',
            'Tire uma foto sua com seus documentos para concluir o cadastro!'),
        Stack(
          children: [
            preview(),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: CameraButtons(
                controller,
                onClose: closeCamera,
                onPictureTake: (newPath) => showPicture(newPath),
                resetImage: this.resetImage,
                canshowotherButtons: imageurl != null,
              ),
            ),
            imageurl == null
                ? SizedBox()
                : Positioned(
                    bottom: 200,
                    right: 0,
                    left: 0,
                    child: Column(
                      children: [
                        Text(
                          'Para tirar outra foto deslize para baixo',
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(AntDesign.down, color: Colors.white)
                      ],
                    ),
                  ),
          ],
        )
      ],
      padding: false,
    );
  }
}

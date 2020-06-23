import 'dart:io';

import 'package:Biquer/components/CameraButtons.dart';
import 'package:Biquer/components/PageTitle.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

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

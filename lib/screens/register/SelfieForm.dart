import 'dart:io';

import 'package:Biquer/components/BaseForm.dart';
import 'package:Biquer/components/CenteredTitle.dart';
import 'package:Biquer/components/PickerOptions.dart';
import 'package:Biquer/model/RegisterData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SelfieForm extends StatefulWidget {
  final PageController pageController;

  const SelfieForm({@required this.pageController});

  @override
  _SelfieFormState createState() => _SelfieFormState();
}

class _SelfieFormState extends State<SelfieForm> {
  String imageurl;

  @override
  void initState() {
    super.initState();
  }

  void showPicture(String path) async {
    RegisterData registerData =
        Provider.of<RegisterData>(context, listen: true);
    setState(() {
      imageurl = path;
    });
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
      return Padding(
        padding: EdgeInsets.all(16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: FadeInImage(
            placeholder: AssetImage('images/toucan.svg'),
            image: FileImage(
              File(imageurl),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.all(16),
      child: CupertinoActivityIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      [
        SvgPicture.asset('images/camera.svg', width: 250, height: 250),
        CenteredTitle(
          title: imageurl == null ? 'Reconhecimento facial' : 'Perfeito!',
          subtitle: imageurl == null
              ? 'Para concluir envie uma foto sua com o documento em mãos para comprovar a identidade.'
              : 'Muito bem agora você está pronto pressione a seta para concluir seu cadastro!',
          textColor: Colors.white,
        ),
        preview(),
        PickerOptions((PickedFile file) {
          showPicture(file.path);
        })
      ],
    );
  }
}

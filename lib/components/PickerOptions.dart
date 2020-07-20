import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';

class PickerOptions extends StatelessWidget {
  final Function onFilePick;

  PickerOptions(this.onFilePick);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        MaterialButton(
          color: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          onPressed: () {
            pickAddressProof(context, ImageSource.gallery);
          },
          child: Container(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(AntDesign.folderopen, color: Colors.white),
                SizedBox(width: 20),
                Text(
                  'Selecionar no dispositivo',
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Ou'),
        ),
        MaterialButton(
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          onPressed: () {
            pickAddressProof(context, ImageSource.camera);
          },
          child: Container(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  AntDesign.camera,
                  color: Colors.black,
                ),
                SizedBox(width: 20),
                Text(
                  'Utilizar câmera',
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<PickedFile> pickAddressProof(
      BuildContext context, ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile == null) {
      var snack = SnackBar(
        content: Text('Ocorreu um erro ao recuperar o documento'),
      );
      Scaffold.of(context).showSnackBar(snack);
      return null;
    } else {
      print('File ${pickedFile.path}');
      onFilePick(pickedFile.path);
    }
  }
}

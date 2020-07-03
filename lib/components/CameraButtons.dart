import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CameraButtons extends StatelessWidget {
  final Function onClose, onPictureTake, resetImage;
  final CameraController controller;
  final bool canshowotherButtons;

  CameraButtons(this.controller,
      {this.onClose,
      this.onPictureTake,
      this.resetImage,
      this.canshowotherButtons = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
      height: 100,
      padding: EdgeInsets.only(top: 10, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () {
              !canshowotherButtons
                  ? takePicture(context, controller)
                  : resetImage();
            },
            elevation: 0,
            backgroundColor: Theme.of(context).textTheme.bodyText1.color,
            child: !canshowotherButtons
                ? onPictureTake == null
                    ? CupertinoActivityIndicator()
                    : SizedBox()
                : Icon(
                    MaterialCommunityIcons.close,
                    color: Theme.of(context).backgroundColor,
                  ),
          ),
        ],
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

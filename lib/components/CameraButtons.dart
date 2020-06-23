import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CameraButtons extends StatelessWidget {
  final Function onClose, onPictureTake, resetImage;
  final CameraController controller;
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

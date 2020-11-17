import 'package:flutter/material.dart';
import 'images.dart';
import 'package:image_picker/image_picker.dart';
import 'vision.dart';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';

Dialogue pics = Dialogue();

class PhotoPreviewScreen extends StatefulWidget {
  @override
  _PhotoPreviewScreenState createState() => _PhotoPreviewScreenState();
}

class _PhotoPreviewScreenState extends State<PhotoPreviewScreen> {
  var picture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pics.showSelectionDialouge(
            context: context,
            camera: camera,
            gallery: gal,
          );
        },
        child: Center(child: Icon(Icons.camera_alt)),
      ),
      body: Center(),
      // Center(
      //   child: Container(
      //     child: FlatButton(
      //       child: Text('get type'),
      //       onPressed: () async {
      //         await getImageLabels(picture);
      //       },
      //     ),
      //   ),
      // ),
    );
  }

  void camera() async {
    var pic = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      picture = pic;
    });
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return ObjectDetection(
          image: picture,
        );
      }),
    );
  }

  void gal() async {
    var pic = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      picture = pic;
    });
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return ObjectDetection(
          image: picture,
        );
      }),
    );
  }
}

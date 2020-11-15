import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Dialogue {
  Future<void> showSelectionDialouge({
    BuildContext context,
    Function camera,
    Function gallery,
  }) {
    return Alert(
      context: context,
      // type: AlertType.info,
      title: 'PICTURE PICKER',
      desc: "Choose your source",
      buttons: [
        DialogButton(
          child: Text('Gallery'),
          onPressed: gallery,
        ),
        DialogButton(
          child: Text('Camera'),
          onPressed: camera,
        ),
      ],
    ).show();
  }
}




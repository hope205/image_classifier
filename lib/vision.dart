import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

List<ImageLabel> Objectprop;

class ObjectDetection extends StatefulWidget {
  final image;
  ObjectDetection({this.image});

  @override
  _ObjectDetectionState createState() => _ObjectDetectionState();
}

class _ObjectDetectionState extends State<ObjectDetection> {
  String name = 'object';
  String entityNum;
  double credibility;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Container(
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.near_me),
                ),
              ),
              Container(
                child: Image.file(widget.image),
              ),
              Column(
                children: [
                  Container(
                    child: MaterialButton(
                      child: Text(
                        'Get Label',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        await getImageLabels(widget.image);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Text(
                    name,
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                  
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future getImageLabels(image) async {
    final gotImage = FirebaseVisionImage.fromFile(image);
    final ImageLabeler labelDetector = FirebaseVision.instance.imageLabeler(
      ImageLabelerOptions(confidenceThreshold: 0.75),
    );
    // final labelDetector = FirebaseVision.instance.imageLabeler();
    List<ImageLabel> labels = await labelDetector.processImage(gotImage);

    for (ImageLabel label in labels) {
      final String text = label.text;
      final String entityId = label.entityId;
      final double confidence = label.confidence;

      setState(() {
        name = text;
      });
      print(entityId);
      print(confidence);
    }
  }
}

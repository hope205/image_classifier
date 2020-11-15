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
                child: SizedBox(height: 45.0),
              ),
              Column(
                children: [
                  Container(
                    child: FlatButton(
                      child: Text(
                        'get type',
                        style: TextStyle(
                          color: Colors.purple,
                          fontSize: 30.0,
                        ),
                      ),
                      onPressed: () async {
                        await getImageLabels(widget.image);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Text(name),
                  // Text(entityNum),
                  // Text(credibility),
                  FlatButton(
                    child: Text(
                      'Back',
                      style: TextStyle(
                        color: Colors.purple,
                        fontSize: 30.0,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
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
    // Future<List<ImageLabel>> getImageLabels(image) async {
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

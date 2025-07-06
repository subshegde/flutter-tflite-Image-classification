import 'dart:io';
import 'dart:developer' as devtools;
import 'package:flutter/services.dart';
import 'package:flutter_tflite_examples/common/constants/paths.dart';
import 'package:flutter_tflite_examples/models/image_classification/mango_leaf_disease_detection/classification_result.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class ClassifierService {
  late Interpreter _interpreter;
  late List<String> _labels;
  final int inputSize = 224;
  bool isModelLoaded = false;
  
  Future<void> loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset(AssetPaths.mangoModel);
      final labelData = await rootBundle.loadString(AssetPaths.mangoLabel);
      _labels = labelData.split('\n').where((e) => e.isNotEmpty).toList();
      isModelLoaded = true;
      devtools.log("Model and labels loaded.");
    } catch (e) {
      devtools.log("Error loading model or labels: $e");
      rethrow;
    }
  }

  Future<ClassificationResult?> classifyImage(File file) async {
    final imageBytes = await file.readAsBytes();
    final img.Image? oriImage = img.decodeImage(imageBytes);
    if (oriImage == null) return null;

    final img.Image resized = img.copyResize(oriImage, width: inputSize, height: inputSize);
    final input = List.generate(1, (_) {
      return List.generate(inputSize, (y) {
        return List.generate(inputSize, (x) {
          final pixel = resized.getPixel(x, y);
          return [
            (pixel.r - 127.5) / 127.5,
            (pixel.g - 127.5) / 127.5,
            (pixel.b - 127.5) / 127.5,
          ];
        });
      });
    });

    final output = List.filled(_labels.length, 0.0).reshape([1, _labels.length]);
    _interpreter.run(input, output);

    final scores = output[0];
    int maxIndex = 0;
    double maxScore = scores[0];

    for (int i = 1; i < scores.length; i++) {
      if (scores[i] > maxScore) {
        maxIndex = i;
        maxScore = scores[i];
      }
    }

    final indexedScores = List.generate(scores.length, (i) => MapEntry(i, scores[i]));
    indexedScores.sort((a, b) => b.value.compareTo(a.value));

    Map<String, double> top3 = {
      for (var i = 0; i < 3 && i < indexedScores.length; i++)
        _labels[indexedScores[i].key]: indexedScores[i].value * 100
    };

    return ClassificationResult(
      label: _labels[maxIndex],
      confidence: maxScore * 100,
      topResults: top3,
    );
  }
}

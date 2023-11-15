// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// @dart=2.9

part of 'google_ml_vision.dart';

void faceDetectorTests() {
  group('$FaceDetector', () {
    final FaceDetector detector = GoogleVision.instance.faceDetector(
      const FaceDetectorOptions(
          enableContours: true, mode: FaceDetectorMode.accurate),
    );

    test('processImage', () async {
      final String tmpFilename = await _loadImage('assets/test_face.jpg');
      final GoogleVisionImage visionImage =
          GoogleVisionImage.fromFilePath(tmpFilename);

      final List<Face> faces = await detector.processImage(visionImage);

      expect(faces.length, 1);
      expect(
        faces[0].getContour(FaceContourType.allPoints).positionsList,
        isNotEmpty,
      );
    });

    test('close', () {
      expect(detector.close(), completes);
    });
  });
}

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import 'dart:io';

class ARScanner extends StatefulWidget {
  const ARScanner({Key? key}) : super(key: key);

  @override
  State<ARScanner> createState() => _ARScannerState();
}

class _ARScannerState extends State<ARScanner> {
  CameraController? _cameraController;
  List<CameraDescription> _cameras = [];
  final TextRecognizer _textRecognizer = TextRecognizer();
  bool _isBusy = false;
  bool _isDetecting = false;
  String _detectedText = '';

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras.isNotEmpty) {
        _cameraController = CameraController(
          _cameras[0],
          ResolutionPreset.medium,
          enableAudio: false,
        );
        await _cameraController!.initialize();
        if (mounted) {
          setState(() {});
        }
      }
    } catch (e) {
      print('Failed to initialize camera: $e');
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _textRecognizer.close();
    super.dispose();
  }

  Future<void> _processImage(CameraImage image) async {
    if (_isBusy) return;
    _isBusy = true;

    try {
      // This is a simplified implementation
      // In a real app, you'd convert the CameraImage to InputImage properly
      // For demonstration, we're using a placeholder method
      InputImage inputImage = _convertCameraImageToInputImage(image);

      final recognizedText = await _textRecognizer.processImage(inputImage);

      String text = recognizedText.text;

      // Check if the text contains math expressions
      if (_containsMathExpression(text)) {
        setState(() {
          _detectedText = text.replaceAll('\n', ' ');
          _isDetecting = false;
        });
      }
    } catch (e) {
      print('Error processing image: $e');
    } finally {
      _isBusy = false;
    }
  }

  // Placeholder method - in a real app this would properly convert formats
  InputImage _convertCameraImageToInputImage(CameraImage image) {
    // This is just a placeholder - real implementation would convert the camera image
    // to an input image format that ML Kit can process
    return InputImage.fromFile(File('placeholder.jpg'));
  }

  bool _containsMathExpression(String text) {
    // Basic check for mathematical expressions
    RegExp mathRegex = RegExp(r'[0-9+\-*/()=]');
    return mathRegex.hasMatch(text);
  }

  void _startDetection() {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      setState(() {
        _isDetecting = true;
        _detectedText = '';
      });

      // In a real implementation, you'd use imageStream
      // This is simplified for demonstration
      _cameraController!.startImageStream((image) {
        if (_isDetecting) {
          _processImage(image);
        }
      });
    }
  }

  void _stopDetection() {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      _cameraController!.stopImageStream();
      setState(() {
        _isDetecting = false;
      });
    }
  }

  void _solveProblem() {
    if (_detectedText.isNotEmpty) {
      final calculatorProvider = Provider.of<CalculatorProvider>(
          context, listen: false);
      calculatorProvider.setInput(_detectedText);
      calculatorProvider.calculate();

      // Navigate back to calculator tab
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Math problem detected and sent to calculator'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Camera preview
              CameraPreview(_cameraController!),

              // Scanning overlay
              _isDetecting
                  ? Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.yellow,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.8,
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.2,
              )
                  : const SizedBox(),

              // Detected text display
              if (_detectedText.isNotEmpty && !_isDetecting)
                Positioned(
                  top: 20,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Detected Math:',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _detectedText,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: _solveProblem,
                              child: const Text('Solve This'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),

        // Controls
        Container(
          padding: const EdgeInsets.all(16),
          color: Theme
              .of(context)
              .colorScheme
              .surface,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: _isDetecting ? _stopDetection : _startDetection,
                icon: Icon(_isDetecting ? Icons.stop : Icons.camera_alt),
                label: Text(
                    _isDetecting ? 'Stop Scanning' : 'Scan Math Problem'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isDetecting ? Colors.red : Theme
                      .of(context)
                      .colorScheme
                      .primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
import 'package:camera/camera.dart';
import 'dart:io';

late List<CameraDescription> cameras;

class CameraScreen extends StatefulWidget {
  final String cloth;
  final String size;
  const CameraScreen({super.key, required this.cloth, required this.size});

  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  bool isCameraInitialized = false;
  XFile? capturedImage;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _controller = CameraController(cameras.first, ResolutionPreset.medium);
    await _controller.initialize();
    setState(() => isCameraInitialized = true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          if (isCameraInitialized) CameraPreview(_controller),
          Positioned(
            bottom: 20,
            child: ElevatedButton(
              onPressed: () async {
                XFile file = await _controller.takePicture();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TryOnScreen(imagePath: file.path, cloth: widget.cloth)),
                );
              },
              child: const Text("Capture"),
            ),
          ),
        ],
      ),
    );
  }
}

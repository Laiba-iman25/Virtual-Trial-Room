import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';





void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  if (cameras.isEmpty) {
    print('No cameras found!');
    return;
  }

  runApp(const MyApp());
}

late List<CameraDescription> cameras;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Virtual Trial Room',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5), // Slower fading time
      vsync: this,
    )..repeat(reverse: true); // Repeating fade animation

    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.7).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        // Set Drawer background to an image
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background2.jpg'), // Replace with your image path
              fit: BoxFit.cover, // Make sure the image covers the entire area
            ),
          ),
          child: ListView(
            children: [
              // DrawerHeader with transparent background
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.transparent, // Set this to transparent to let the image show through
                ),
                child: Container(), // Optionally, you can put text or a logo here
              ),
              // Increase the size of the "Clothes" title
              ListTile(
                title: Text(
                  'Clothes',
                  style: GoogleFonts.exo(
                    color: Colors.white,
                    fontSize: 24, // Increased font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CategoriesScreen()),
                  );
                },
              ),
              // Categories under Clothes with tab space and larger font size
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: ListTile(
                  title: Text(
                    'Shirts',
                    style: GoogleFonts.exo(
                      color: Colors.white,
                      fontSize: 22, // Increased font size
                    ),
                  ),
                  onTap: () {
                    // Navigate to Shirts category
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: ListTile(
                  title: Text(
                    'Pants',
                    style: GoogleFonts.exo(
                      color: Colors.white,
                      fontSize: 22, // Increased font size
                    ),
                  ),
                  onTap: () {
                    // Navigate to Pants category
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: ListTile(
                  title: Text(
                    'Skirts',
                    style: GoogleFonts.exo(
                      color: Colors.white,
                      fontSize: 22, // Increased font size
                    ),
                  ),
                  onTap: () {
                    // Navigate to Skirts category
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: ListTile(
                  title: Text(
                    'Dresses',
                    style: GoogleFonts.exo(
                      color: Colors.white,
                      fontSize: 22, // Increased font size
                    ),
                  ),
                  onTap: () {
                    // Navigate to Dresses category
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Container with background image to cover the entire screen
          FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background.jpg'),
                  fit: BoxFit.cover, // Ensures the background fully covers the screen
                ),
              ),
            ),
          ),
          // Animated text
          Positioned(
            top: 600,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'TRYONMEE!!',
                    textStyle: GoogleFonts.exo(
                      fontSize: 48.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    speed: const Duration(milliseconds: 150),
                  ),
                ],
                totalRepeatCount: 1000,
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
              ),
            ),
          ),
          // Menu icon - Simple hanger icon (using custom widget)
          Positioned(
            top: 30,
            left: 20,
            child: IconButton(
              icon: Icon(
                Icons.checkroom, // A simple hanger-like icon
                size: 40,
                color: Colors.white,
              ),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
          ),
        ],
      ),
    );
  }
}






 // Import the package

 // Import the package



class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> with TickerProviderStateMixin {
  final List<Map<String, String>> categories = [
    {'name': 'Dresses', 'image': 'assets/clothes/categories/DRESS.png'},
    {'name': 'Shirts', 'image': 'assets/clothes/categories/SHIRT1.png'},
    {'name': 'Pants', 'image': 'assets/clothes/categories/PANT.png'},
    {'name': 'Skirts', 'image': 'assets/clothes/categories/SKIRT1.png'},
  ];

  late AnimationController _controller;
  late List<Animation<double>> _fadeAnimations;
  late List<Animation<double>> _scaleAnimations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimations = List.generate(
      categories.length,
      (index) => Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(index * 0.3, 1.0, curve: Curves.easeIn),
        ),
      ),
    );

    _scaleAnimations = List.generate(
      categories.length,
      (index) => Tween<double>(begin: 0.8, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(index * 0.3, 1.0, curve: Curves.easeOut),
        ),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Categories',
            style: GoogleFonts.exo(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/background2.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 100),
              Expanded(
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(categories.length, (index) {
                        final category = categories[index];
                        return FadeTransition(
                          opacity: _fadeAnimations[index],
                          child: ScaleTransition(
                            scale: _scaleAnimations[index],
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ClothesScreen(category: category['name']!),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 30),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      category['image']!,
                                      width: 220,
                                      height: 220,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      category['name']!,
                                      style: GoogleFonts.exo(
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ClothesScreen extends StatefulWidget {
  final String category;

  const ClothesScreen({super.key, required this.category});

  @override
  _ClothesScreenState createState() => _ClothesScreenState();
}


class _ClothesScreenState extends State<ClothesScreen> {
  final PageController _pageController = PageController();
  double _opacity = 1.0;
  double _scale = 1.0;

  final Map<String, List<String>> clothes = {
    'Dresses': [
      'assets/clothes/dress1.png', 'assets/clothes/dress2.png', 'assets/clothes/dress3.png',
      'assets/clothes/dress4.png', 'assets/clothes/dress5.png', 'assets/clothes/dress6.png',
      'assets/clothes/dress7.png', 'assets/clothes/dress8.png', 'assets/clothes/dress9.png'
    ],
    'Shirts': [
      'assets/clothes/shirt.png', 'assets/clothes/shirt2.png', 'assets/clothes/shirt4.png',
      'assets/clothes/shirt5.png', 'assets/clothes/shirt6.png', 'assets/clothes/shirt7.png',
      'assets/clothes/shirt8.png', 'assets/clothes/shirt9.png', 'assets/clothes/shirt10.png',
      'assets/clothes/shirt11.png', 'assets/clothes/shirt12.png', 'assets/clothes/shirt13.png',
      'assets/clothes/shirt14.png', 'assets/clothes/shirt15.png', 'assets/clothes/shirt16.png'
    ],
    'Pants': [
      'assets/clothes/pants1.png', 'assets/clothes/pants2.png', 'assets/clothes/pants3.png',
      'assets/clothes/pants4.png', 'assets/clothes/pants5.png', 'assets/clothes/pants6.png',
      'assets/clothes/pants7.png'
    ],
    'Skirts': [
      'assets/clothes/skirt1.png', 'assets/clothes/skirt2.png', 'assets/clothes/skirt3.png',
      'assets/clothes/skirt4.png', 'assets/clothes/skirt5.png', 'assets/clothes/skirt6.png',
      'assets/clothes/skirt7.png', 'assets/clothes/skirt8.png'
    ],
  };

  @override
  void initState() {
    super.initState();
    // Ensure the first item is animated correctly
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _opacity = 1.0;
        _scale = 1.1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Access category through widget and ensure it exists in the clothes map
    final categoryClothes = clothes[widget.category];

    if (categoryClothes == null || categoryClothes.isEmpty) {
      return Scaffold(
        body: Center(
          child: Text("No clothes found for this category."),
        ),
      );
    }

    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/background2.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // White Back Button (Top Left)
          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          // PageView with animated transition effects
          Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: PageView.builder(
              controller: _pageController,
              itemCount: categoryClothes.length,
              onPageChanged: (index) {
                setState(() {
                  _opacity = 0.0;
                  _scale = 0.8;
                });

                Future.delayed(const Duration(milliseconds: 200), () {
                  setState(() {
                    _opacity = 1.0;
                    _scale = 1.1;
                  });
                });
              },
              itemBuilder: (context, index) {
                final cloth = categoryClothes[index];

                return Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SizeScreen(cloth: cloth)),
                      );
                    },
                    child: AnimatedOpacity(
                      opacity: _opacity,
                      duration: const Duration(milliseconds: 500),
                      child: AnimatedScale(
                        scale: _scale,
                        duration: const Duration(milliseconds: 500),
                        child: Image.asset(
                          cloth,
                          fit: BoxFit.cover,
                          height: 300,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}




class SizeScreen extends StatelessWidget {
  final String cloth;
  const SizeScreen({super.key, required this.cloth});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, // No default app bar to maintain a fullscreen look
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/background2.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // White Back Button at the top-left
          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          // Content layout
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Animated Text
                AnimatedDefaultTextStyle(
                  style: GoogleFonts.exo(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  duration: const Duration(seconds: 1),
                  child: const Text("Choose Your Size"),
                ),
                const SizedBox(height: 20),
                // Display the selected cloth image
                AnimatedOpacity(
                  opacity: 1.0,
                  duration: const Duration(seconds: 1),
                  child: Image.asset(cloth, width: 200, height: 300),
                ),
                const SizedBox(height: 40),
                // Size selection buttons
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 20,
                  runSpacing: 20,
                  children: ['Small', 'Medium', 'Large'].map((size) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CameraScreen(cloth: cloth, size: size),
                            ),
                          );
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              size,
                              style: GoogleFonts.exo(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

 // Import the TryOnScreen file


class CameraScreen extends StatefulWidget {
  final String cloth;
  final String size;
  const CameraScreen({super.key, required this.cloth, required this.size});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;
  int _currentCameraIndex = 0;
  bool _isFlashOn = false;
  bool _isTimerOn = false;
  int _timerCount = 3;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() {
    _cameraController = CameraController(
      cameras[_currentCameraIndex],
      ResolutionPreset.max,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    _initializeControllerFuture = _cameraController.initialize().then((_) {
      _cameraController.setFlashMode(FlashMode.off);
      setState(() {});
    }).catchError((e) {
      print('Error initializing camera: $e');
    });
  }

  void _switchCamera() {
    setState(() {
      _currentCameraIndex = (_currentCameraIndex + 1) % cameras.length;
      _initializeCamera();
    });
  }

  void _toggleFlash() {
    setState(() {
      _isFlashOn = !_isFlashOn;
      _cameraController.setFlashMode(_isFlashOn ? FlashMode.torch : FlashMode.off);
    });
  }

  void _startTimer() {
    setState(() {
      _isTimerOn = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (_timerCount > 0) {
        setState(() {
          _timerCount--;
        });
        _startTimer();
      } else {
        _takePicture();
      }
    });
  }

  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;
      final image = await _cameraController.takePicture();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TryOnScreen(
            imagePath: image.path,
            cloth: widget.cloth,
            size: widget.size,
          ),
        ),
      );
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/background2.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_cameraController);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          if (_isTimerOn)
            Positioned(
              top: 30,
              left: MediaQuery.of(context).size.width / 2 - 50,
              child: Text(
                '$_timerCount',
                style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          // Replacing the box with the human outline image
          Center(
            child: Container(
              width: 450,
              height: 2500,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/human_outline.png'), // Your human outline image
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 10,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Back Button
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                // Flash Button
                IconButton(
                  icon: Icon(
                    _isFlashOn ? Icons.flash_on : Icons.flash_off,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: _toggleFlash,
                ),
                // Timer Button
                IconButton(
                  icon: Icon(
                    _isTimerOn ? Icons.timer_off : Icons.timer,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    setState(() {
                      _isTimerOn = !_isTimerOn;
                      _timerCount = 3;
                    });
                  },
                ),
                // Switch Camera Button
                IconButton(
                  icon: const Icon(Icons.switch_camera, color: Colors.white, size: 30),
                  onPressed: _switchCamera,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 50,
            left: MediaQuery.of(context).size.width / 2 - 25,
            child: FloatingActionButton(
              onPressed: _isTimerOn ? _startTimer : _takePicture,
              child: const Icon(Icons.camera, color: Colors.white),
              backgroundColor: Colors.brown[800],
            ),
          ),
        ],
      ),
    );
  }
}

class TryOnScreen extends StatefulWidget {
  final String imagePath;
  final String cloth;
  final String size;

  const TryOnScreen({
    Key? key,
    required this.imagePath,
    required this.cloth,
    required this.size,
  }) : super(key: key);

  @override
  _TryOnScreenState createState() => _TryOnScreenState();
}



class _TryOnScreenState extends State<TryOnScreen> {
  late double _clothTop;
  late double _clothLeft;
  late double _clothWidth;
  late double _clothHeight;
  late double _scaleFactor;
  late double _bodyBoxHeight;
  GlobalKey _repaintKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    // Set initial scale based on size
    if (widget.size == 'Small') {
      _scaleFactor = 0.9; // Adjust scale factor for small size
    } else if (widget.size == 'Medium') {
      _scaleFactor = 1.0; // Medium size scale factor
    } else {
      _scaleFactor = 1.2; // Large size scale factor
    }

    // The height of the human outline image
    _bodyBoxHeight = 700; // Adjust as per the actual height of the human outline image

    // Set initial position and size based on clothing type
    _setInitialClothingPosition();
  }

  void _setInitialClothingPosition() {
    _clothLeft = 75; // Default left position

    // For clothing types, set specific positioning relative to the outline

    if (widget.cloth.contains("dress")) {
      // Dress starts slightly down from the top and goes till the bottom
      _clothHeight = 400 * _scaleFactor; 
      _clothWidth = 200 * _scaleFactor;
      _clothTop = _bodyBoxHeight * 0.15; // A bit down from the top

    } else if (widget.cloth.contains("shirt") || widget.cloth.contains("top")) {
      // Shirt starts a bit down from the top and goes till the middle
      _clothHeight = 160 * _scaleFactor;
      _clothWidth = 180 * _scaleFactor;
      _clothTop = _bodyBoxHeight * 0.22; // A bit down from the top

    } else if (widget.cloth.contains("pants") || widget.cloth.contains("jeans")) {
      // Pants start from the middle of the outline and go to the bottom
      _clothHeight = 250 * _scaleFactor;
      _clothWidth = 180 * _scaleFactor;
      _clothTop = _bodyBoxHeight * 0.3; // Start at the middle of the outline

    } else if (widget.cloth.contains("skirt")) {
      // Skirt starts from the middle and goes halfway to the bottom
      _clothHeight = 200 * _scaleFactor;
      _clothWidth = 180 * _scaleFactor;
      _clothTop = _bodyBoxHeight * 0.4; // Start at the middle of the outline

    } else {
      _clothHeight = 300 * _scaleFactor; // Default height
      _clothWidth = 200 * _scaleFactor; // Default width
      _clothTop = _bodyBoxHeight * 0.3; // Default placement
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/background2.jpg', // Change to your background image
              fit: BoxFit.cover,
            ),
          ),
          // Back Button (White Arrow)
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          SafeArea(
            child: Center(
              child: RepaintBoundary(
                key: _repaintKey,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Human Outline Image
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Image.asset(
                        'assets/human_outline.png', // Path to the human outline image
                        height: _bodyBoxHeight,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Reduce picture size
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: Image.file(File(widget.imagePath), fit: BoxFit.contain),
                    ),
                    // Draggable Clothing Item
                    Positioned(
                      top: _clothTop,
                      left: _clothLeft,
                      child: GestureDetector(
                        onPanUpdate: (details) {
                          setState(() {
                            _clothTop += details.delta.dy;
                            _clothLeft += details.delta.dx;
                          });
                        },
                        child: Image.asset(
                          widget.cloth,
                          width: _clothWidth,
                          height: _clothHeight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



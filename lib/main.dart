import 'package:dlinking/green_screen.dart';
import 'package:dlinking/red_screen.dart';
import 'package:dlinking/services.dart'; // Ensure you have the DeepLinkHandler class here
import 'package:dlinking/unknown_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late DeepLinkHandler _deepLinkHandler;

  @override
  void initState() {
    super.initState();

    // Initialize the DeepLinkHandler
    _deepLinkHandler = DeepLinkHandler(context);
    _deepLinkHandler.init();  // Start listening for deep links
  }

  @override
  void dispose() {
    _deepLinkHandler.dispose(); // Clean up when not needed anymore
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deep Linking Example',
      initialRoute: '/',
      onGenerateRoute: (settings) {
        // Check for deep link navigation
        if (settings.name == '/redscreen') {
          return MaterialPageRoute(builder: (_) => RedScreen());
        } else if (settings.name == '/greenscreen') {
          return MaterialPageRoute(builder: (_) => GreenScreen());
        } else {
          // Handle any unknown path
          return MaterialPageRoute(builder: (_) => UnknownScreen());
        }
      },
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the RedScreen
            Navigator.pushNamed(context, '/redscreen');
          },
          child: Text('Go to Red Screen'),
        ),
      ),
    );
  }
}

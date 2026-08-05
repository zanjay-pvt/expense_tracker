import 'package:expense_tracker/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    // Wait for the duration of your GIF (change seconds to match your GIF's length)
    await Future.delayed(const Duration(seconds: 5));

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.black, // Change to match your GIF's background color
      body: SizedBox.expand(
        child: Image.asset(
          'lib/asset/animation/fintech_intro_4k.gif',
          fit: BoxFit
              .fitWidth, // Keeps your landscape ratio filling the screen nicely
        ),
      ),
    );
  }
}

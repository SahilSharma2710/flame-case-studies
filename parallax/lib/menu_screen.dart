import 'dart:async'; // Import async for Future.delayed

import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:parallax/jungle_parallax.dart';
import 'package:parallax/star_parallax.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  // Helper function to build the Game screen with a back button
  Widget _buildGameScreen(BuildContext context, Widget gameWidget) {
    return Scaffold(
      // Use Scaffold for easy AppBar or FloatingActionButton placement
      // Or use Stack for more custom positioning
      body: Stack(
        children: [
          // The GameWidget fills the screen
          Positioned.fill(child: gameWidget),
          // Positioned Back Button
          Positioned(
            top: 40.0, // Adjust position as needed (consider safe area)
            left: 10.0,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () {
                // Optionally reset orientation if needed
                Flame.device.setPortrait(); // Reset if landscape was set
                Navigator.of(context).pop();
              },
              tooltip: 'Back to Menu', // Optional: Accessibility feature
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TapTransformButton(
              text: 'Load Star Parallax',
              onPressed: () {
                // Reset orientation before pushing new route
                Flame.device.setPortrait(); // Ensure portrait for star parallax
                Navigator.of(context).push(
                  MaterialPageRoute(
                    // Use the helper function to build the screen
                    builder: (context) => _buildGameScreen(
                      context,
                      GameWidget(game: StarParallaxExample()),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            TapTransformButton(
              text: 'Load Jungle Parallax',
              onPressed: () {
                // Set orientation before pushing new route
                Flame.device.setLandscape();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    // Use the helper function to build the screen
                    builder: (context) => _buildGameScreen(
                      context,
                      GameWidget(game: JungleParallaxExample()),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TapTransformButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const TapTransformButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  State<TapTransformButton> createState() => _TapTransformButtonState();
}

class _TapTransformButtonState extends State<TapTransformButton> {
  bool _isPressed = false;
  final _borderRadius = BorderRadius.circular(16);
  final _borderWidth = 2.0;
  final _animationDuration = const Duration(milliseconds: 150);

  void _handleTap() {
    widget.onPressed(); // This now includes setting orientation AND navigating

    setState(() => _isPressed = true);

    Future.delayed(_animationDuration, () {
      if (mounted) {
        setState(() => _isPressed = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedScale(
        scale: _isPressed ? 1.1 : 1.0,
        duration: _animationDuration,
        child: Container(
          padding: _isPressed ? EdgeInsets.all(_borderWidth) : EdgeInsets.zero,
          decoration: _isPressed
              ? BoxDecoration(
                  borderRadius: _borderRadius,
                  gradient: const LinearGradient(
                    colors: [Colors.greenAccent, Colors.lightGreen],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                )
              : BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: _borderRadius,
                  border: Border.all(color: Colors.green, width: _borderWidth),
                ),
          child: Container(
            padding: EdgeInsets.all(16 - (_isPressed ? _borderWidth : 0)),
            decoration: BoxDecoration(
              color: _isPressed ? Colors.black : Colors.transparent,
              borderRadius: _borderRadius,
            ),
            child: Text(
              widget.text,
              style: const TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

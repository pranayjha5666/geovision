import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_earth_globe/flutter_earth_globe.dart';
import 'package:flutter_earth_globe/flutter_earth_globe_controller.dart';
import 'package:geovision/core/theme/theme_bloc.dart';
import 'package:geovision/features/auth/bloc/auth_bloc.dart';
import 'package:geovision/widgets/custom_button.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late FlutterEarthGlobeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FlutterEarthGlobeController(
      rotationSpeed: 0.05,
      isBackgroundFollowingSphereRotation: true,
      surface: Image.asset('assets/images/2k_earth-day.jpg').image,
      isRotating: true,
      isZoomEnabled: true,
      zoom: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeBloc>().state == ThemeMode.dark;
    return Scaffold(
      body: SafeArea(
          child: Stack(
            children: [
              // Background
              Positioned.fill(
                child: isDarkMode
                    ? Image.asset(
                  "assets/images/2k_stars.jpg",
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                )
                    : Container(color: Colors.white),
              ),

              // Globe
              FlutterEarthGlobe(
                controller: _controller,
                radius: 70,
              ),

              // Logo
              Positioned(
                top: 10,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: isDarkMode
                      ? Image.asset(
                    "assets/images/logo.png",
                    width: 200,
                  )
                      : Image.asset(
                    "assets/images/logolight.png",
                    width: 200,
                  )
                ),
              ),

              // Text below the logo
              Positioned(
                top: 130,
                left: 0,
                right: 0,
                child: Text(
                  "Unlocking Opportunities\nShaping Success",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),

              // Get Started button
              BlocListener<AuthBloc,AuthState>(
                listener: (context,state){
                  if(state is AuthNeedsOnboarding){
                    Navigator.pushReplacementNamed(context, '/onboarding');
                  }
                  if(state is AuthisAlreadyLoggedIn){
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                  if(state is AuthNotAlreadyLoggedIn){
                    Navigator.pushReplacementNamed(context, '/auth');
                  }
                },
                child: Positioned(
                  bottom: 40,
                  left: 50,
                  right: 50,
                  child: CustomButton(
                    text: "Get Started",
                    onTap: () {
                      context.read<AuthBloc>().add(AuthCheckStatus());
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}

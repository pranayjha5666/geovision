import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geovision/core/theme/theme_bloc.dart';
import 'package:geovision/features/auth/presentation/pages/login_screen.dart';
import 'package:geovision/features/auth/presentation/pages/signup_screen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final PageController _pageController = PageController();
  int _selectedPage = 0;

  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeBloc>().state == ThemeMode.dark;

    return Scaffold(
      body: Container(
        decoration: isDarkMode
            ? BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/2k_stars.jpg"),
            fit: BoxFit.cover,
          ),
        )
            : null,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => _goToPage(0),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode
                            ? (_selectedPage == 0 ? Colors.white : Colors.grey)
                            : (_selectedPage == 0 ? Colors.black : Colors.black38),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () => _goToPage(1),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode
                            ? (_selectedPage == 1 ? Colors.white : Colors.grey)
                            : (_selectedPage == 1 ? Colors.black : Colors.black38),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _selectedPage = index;
                    });
                  },
                  children: [
                    LoginScreen(),
                    SignupScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

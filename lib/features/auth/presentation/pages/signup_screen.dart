import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geovision/core/theme/theme_bloc.dart';
import 'package:geovision/features/auth//bloc/auth_bloc.dart';
import 'package:geovision/widgets/custom_button.dart';
import 'package:geovision/widgets/custom_textformfield.dart';
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _emailController=new TextEditingController();
  TextEditingController _passwordController=new TextEditingController();
  TextEditingController _conformpasswordController=new TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConformPasswordVisible = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();




  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    final RegExp upperCase = RegExp(r'[A-Z]');
    final RegExp lowerCase = RegExp(r'[a-z]');
    final RegExp digit = RegExp(r'\d');
    final RegExp specialCharacter = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

    if (!upperCase.hasMatch(value)) {
      return 'Password must contain at least 1 uppercase letter';
    }
    if (!lowerCase.hasMatch(value)) {
      return 'Password must contain at least 1 lowercase letter';
    }
    if (!digit.hasMatch(value)) {
      return 'Password must contain at least 1 number';
    }
    if (!specialCharacter.hasMatch(value)) {
      return 'Password must contain at least 1 special character';
    }
    return null;
  }
  String? confirmPasswordValidator(String? value) {
    if(passwordValidator(value)!=null)return passwordValidator(value);
    // if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != _passwordController.text) return 'Passwords do not match';
    return null;
  }


  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }



  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final isDarkMode = context.watch<ThemeBloc>().state == ThemeMode.dark;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocListener<AuthBloc,AuthState>(
        listener: (context, state) {
          if(state is AuthLoading){
            showDialog(context: context, builder: (context) => const Center(child: CircularProgressIndicator()),
            );
          }
          else if(state is AuthEmailVerificationSent){
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Successfully Created, Check Email To Verify")),
            );
            Navigator.pushNamedAndRemoveUntil(context, '/auth', (route) => false);
          }
          else if (state is AuthSuccess) {
            Navigator.pop(context);
            Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
          } else if (state is AuthNeedsOnboarding) {
            Navigator.pop(context);
            Navigator.pushNamedAndRemoveUntil(context, '/onboarding', (route) => false);
          }
          else if(state is AuthFailure){
            Navigator.pop(context);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                if (isDarkMode)
                  Image.asset(
                    "assets/images/logo.png",
                    width: 200,
                  )
                else
                  Image.asset(
                    "assets/images/logolight.png",
                    width: 200,
                  ),
                SizedBox(height: screenHeight * 0.15),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextFormField(
                      validator: emailValidator,
                        controller: _emailController, hintText: "Email", prefixIcon: Icons.email_outlined),
                    SizedBox(height: 15,),
                    CustomTextFormField(
                      validator: passwordValidator,
                      controller: _passwordController,
                      hintText: "Enter Password",
                      prefixIcon: Icons.lock_outline,
                      suffixIcon: _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      isPassword: !_isPasswordVisible,
                      onSuffixIconTap: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    SizedBox(height: 15,),
                    CustomTextFormField(
                      validator: confirmPasswordValidator,
                      controller: _conformpasswordController,
                      hintText: "Enter Conform Password",
                      prefixIcon: Icons.lock_outline,
                      suffixIcon: _isConformPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      isPassword: !_isConformPasswordVisible,
                      onSuffixIconTap: () {
                        setState(() {
                          _isConformPasswordVisible = !_isConformPasswordVisible;
                        });
                      },
                    ),
                    SizedBox(height: 20,),
                    // Inside SignupScreen
                    CustomButton(
                      text: "Sign Up",
                      onTap: () {
                        if(_formKey.currentState!.validate()){
                          context.read<AuthBloc>().add(
                            AuthSignUpEvent(
                              email: _emailController.text.trim(),
                              password: _passwordController.text,
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: (){
                        context.read<AuthBloc>().add(
                          AuthGoogleSignintEvent(),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                            color: Color(0xFF21c063),
                            border: Border(
                            ),
                            borderRadius: BorderRadius.circular(25)
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/google.png",height: 25,),
                            SizedBox(width: 15,),
                            Text(
                              "Continue With Google",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? Colors.black : Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

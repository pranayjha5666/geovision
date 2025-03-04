import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geovision/core/theme/theme_bloc.dart';
import 'package:geovision/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:geovision/features/onboarding/bloc/onboarding_event.dart';
import 'package:geovision/features/onboarding/bloc/onboarding_state.dart';
import 'package:geovision/widgets/custom_button.dart';
import 'package:geovision/widgets/custom_textformfield.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}



class _OnboardingScreenState extends State<OnboardingScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _businessCategoryController = TextEditingController();
  final List<TextEditingController> _achievementsControllers = [TextEditingController()];
  bool _hasBusiness = false;
  File? _selectedImage;
  bool _hasAchievements = false;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: CropAspectRatio(ratioX: 16, ratioY: 9),
        compressQuality: 80,
        uiSettings: [
          AndroidUiSettings(toolbarTitle: 'Crop Image'),
          IOSUiSettings(title: 'Crop Image')
        ],
      );
      if (croppedFile != null) {
        setState(() => _selectedImage = File(croppedFile.path));
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _businessNameController.dispose();
    _businessCategoryController.dispose();
    for (var controller in _achievementsControllers) {
      controller.dispose();
    }
    super.dispose();
  }





  void _handleSubmit(BuildContext context) {
    if (!_formKey.currentState!.validate() || _selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    context.read<OnboardingBloc>().add(
      SaveOnboardingDataEvent(
        hasachievements: _hasAchievements,
        profileImage: _selectedImage!,
        name: _nameController.text,
        phone: _phoneController.text,
        hasBusiness: _hasBusiness,
        businessName: _businessNameController.text,
        businessCategory: _businessCategoryController.text,
        achievements: _achievementsControllers
            .map((c) => c.text.trim())
            .where((text) => text.isNotEmpty)
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
   final isDarkMode = context.watch<ThemeBloc>().state == ThemeMode.dark;

    return BlocListener<OnboardingBloc, OnboardingState>(
      listener: (context, state) {
      if (state is OnboardingLoading) {
        showDialog(
          context: context,
          builder: (context) =>
          const Center(child: CircularProgressIndicator()),
        );
      }
      else if (state is OnboardingSuccess) {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        }
      else if (state is OnboardingFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },

    child: Scaffold(
        body: SafeArea(
          child: Container(
            height: double.infinity,
            decoration: isDarkMode
                ? BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/2k_stars.jpg"),
                fit: BoxFit.cover,
              ),
            )
                : null,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          backgroundColor: isDarkMode ? Colors.white : Colors.black,
                          radius: 50,
                          backgroundImage: _selectedImage != null ? FileImage(_selectedImage!) : null,
                          child: _selectedImage == null ? Icon(Icons.person_outline, size: 50, color: isDarkMode ? Colors.black : Colors.white,) : null,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    CustomTextFormField(
                      controller: _nameController,
                      hintText: "Name",
                      prefixIcon: Icons.person,
                      validator: (value) => value!.isEmpty ? 'Name is required' : null,
                    ),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      controller: _phoneController,
                      hintText: "Phone Number",
                      keyboardType: TextInputType.phone,
                      prefixIcon: Icons.phone,
                      validator: (value) => value!.isEmpty ? 'Phone number is required' : (value.length == 10 ? null : 'Enter a valid 10-digit phone number'),
                    ),
                    const SizedBox(height: 10),
                    SwitchListTile(
                      title: Text("Do you have a business?",style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),),
                      value: _hasBusiness,
                      activeColor: Colors.green,
                      onChanged: (value) => setState(() => _hasBusiness = value),
                    ),
                    if (_hasBusiness) ...[
                      CustomTextFormField(
                        controller: _businessNameController,
                        hintText: "Business Name",
                        prefixIcon: Icons.business,
                        validator: (value) => value!.isEmpty ? 'Business name is required' : null,
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        controller: _businessCategoryController,
                        hintText: "Business Category",
                        prefixIcon: Icons.category,
                        validator: (value) => value!.isEmpty ? 'Business category is required' : null,
                      ),
                    ],
                    const SizedBox(height: 10),
                    SwitchListTile(
                        title: Text("Do you have any achievements?",style: TextStyle(
                        fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),),
                        value: _hasAchievements,
                        activeColor: Colors.green,
                        onChanged: (value) {
                          setState(() {
                            _hasAchievements = value;
                            if (value && _achievementsControllers.isEmpty) {
                              _achievementsControllers.add(TextEditingController());
                            }
                          });
                        }),
                    if (_hasAchievements) ...[
                      Column(
                        children: [
                          for (var controller in _achievementsControllers)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: CustomTextFormField(
                                controller: controller,
                                hintText: "Achievement",
                                prefixIcon: Icons.star,
                                suffixIcon: Icons.delete,
                                onSuffixIconTap: () => setState(() => _achievementsControllers.remove(controller)),
                              ),
                            ),
                          TextButton(
                            onPressed: () {
                              if (_achievementsControllers.isNotEmpty &&
                                  _achievementsControllers.last.text.trim().isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Please fill the current achievement field first!'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              } else {
                                setState(() {
                                  _achievementsControllers.add(TextEditingController());
                                });
                              }
                            },
                            child: Text("Add More"),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 20),

                    CustomButton(
                      onTap: () => _handleSubmit(context),
                      text: 'Save and Continue',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

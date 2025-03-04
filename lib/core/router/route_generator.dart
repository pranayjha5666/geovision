import 'package:flutter/material.dart';
import 'package:geovision/features/addBusiness/presentation/pages/business_info_screen.dart';
import 'package:geovision/features/addBusiness/presentation/pages/loading_screen.dart';
import 'package:geovision/features/addBusiness/presentation/pages/location_screen.dart';
import 'package:geovision/features/addBusiness/presentation/pages/review_screen.dart';
import 'package:geovision/features/addBusiness/presentation/pages/search_location.dart';
import 'package:geovision/features/addBusiness/presentation/pages/selectcategory_screen.dart';
import 'package:geovision/features/auth/presentation/pages/auth_screen.dart';
import 'package:geovision/features/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:geovision/user_model/location_model.dart';
import '../../features/splash/presentation/pages/splash_screen.dart';
import '../../features/auth/presentation/pages/login_screen.dart';
import '../../features/auth/presentation/pages/signup_screen.dart';
import '../../features/auth/presentation/pages/forgot_password_screen.dart';
import '../../features/home/presentation/pages/home_screen.dart';
// import '../../features/business/presentation/pages/business_details_screen.dart';
// import '../../features/business/presentation/pages/add_business_screen.dart';
import '../../features/profile/presentation/pages/profile_screen.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.auth:
        return MaterialPageRoute(builder: (_) => AuthScreen(),);
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case AppRoutes.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRoutes.businessDetails:
        // return MaterialPageRoute(builder: (_) => const BusinessDetailsScreen());
      case AppRoutes.addBusiness:
        // return MaterialPageRoute(builder: (_) => const AddBusinessScreen());
      case AppRoutes.searchlocation:
        return MaterialPageRoute(builder: (_) => const SearchLocation());
      case AppRoutes.location:
        final location = settings.arguments as LocationModel;

        return MaterialPageRoute(builder: (_) =>  LocationScreen(location: location));
      case AppRoutes.selectcategory:
        return MaterialPageRoute(builder: (_) => const SelectcategoryScreen());
      case AppRoutes.businessinfo:
        return MaterialPageRoute(builder: (_) => const BusinessInfoScreen());
      case AppRoutes.review:
        return MaterialPageRoute(builder: (_) => const ReviewScreen());
      case AppRoutes.loading:
        return MaterialPageRoute(builder: (_) => const LoadingScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page Not Found')),
          ),
        );
    }
  }
}

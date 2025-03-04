import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geovision/core/router/route_generator.dart';
import 'package:geovision/core/theme/app_theme.dart';
import 'package:geovision/core/theme/theme_bloc.dart';
import 'package:geovision/features/addBusiness/bloc/data/searchlocationrepo/searchlocationlist_repo.dart';
import 'package:geovision/features/addBusiness/bloc/searchlocationBloc/searchlocation_bloc.dart';
import 'package:geovision/features/addBusiness/bloc/searchlocationBloc/searchlocation_event.dart';
import 'package:geovision/features/auth/bloc/auth_bloc.dart';
import 'package:geovision/features/auth/data/repositories/auth_repository.dart';
import 'package:geovision/features/home/presentation/bloc/bottom_nav_bloc.dart';
import 'package:geovision/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:geovision/features/onboarding/data/cloudinaryservices.dart';
import 'package:geovision/features/onboarding/data/onboarding_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");


  await Firebase.initializeApp();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeBloc(),),
        BlocProvider(create: (_) => AuthBloc(AuthRepository()),),
        BlocProvider(create: (_) => OnboardingBloc(OnboardingRepository(CloudinaryServices())),),
        BlocProvider(create: (_) => BottomNavBloc(),),
        BlocProvider(create: (_) => LocationBloc(SearchlocationlistRepo())..add(FetchLocationsEvent()),),

      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;

    return BlocBuilder<ThemeBloc, ThemeMode>(
      builder: (context, themeMode) {
        context.read<ThemeBloc>().updateTheme(brightness);
        return MaterialApp(
          title: 'Flutter Demo',
          themeMode: themeMode,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteGenerator.generateRoute,
        );
      },
    );
  }
}

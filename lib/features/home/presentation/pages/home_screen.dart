import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geovision/core/theme/theme_bloc.dart';
import 'package:geovision/features/business/presentation/pages/business_screen.dart';
import 'package:geovision/features/home/presentation/bloc/bottom_nav_bloc.dart';
import 'package:geovision/features/insights_and_news/presentation/pages/insights_and_news.dart';
import 'package:geovision/features/profile/presentation/pages/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  List<Widget> pages = [
    BusinessScreen(),
    InsightsAndNews(),
    ProfileScreen()
  ];

  // int idx = 0;
  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeBloc>().state == ThemeMode.dark;
    return BlocBuilder<BottomNavBloc,BottomNavState>(
      builder: (context, state) {
        int idx=state.index;
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: isDarkMode ? Colors.black : Colors.white,
            onTap: (index) => context.read<BottomNavBloc>().add(ChangeTab(index)),
            selectedItemColor: isDarkMode ? Colors.white : Colors.black,
            unselectedItemColor: isDarkMode ? Colors.black : Colors.white,
            currentIndex: idx,
            items: [
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: Icon(
                  idx == 0 ? Icons.business_center : Icons.business_center_outlined,
                  color: idx == 0 ? isDarkMode ? Colors.white : Colors.black : Colors.grey,
                ),
                label: "Business",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  idx == 1 ? Icons.newspaper : Icons.newspaper_outlined,
                  color: idx == 1 ? isDarkMode ? Colors.white : Colors.black : Colors.grey,
                ),
                label: "Insights and News",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  idx == 2 ? Icons.person : Icons.person_outline,
                  color: idx == 2 ? isDarkMode ? Colors.white : Colors.black : Colors.grey,
                ),
                label: "Profile",
              ),
            ],
          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: isDarkMode
                ? BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/2k_stars.jpg"),
                fit: BoxFit.cover,
              ),
            )
                : null,
            child: SafeArea(
              child: IndexedStack(
                children: pages,
                index: idx,
              ),
            ),
          ),
        );
      },
    );
  }
}

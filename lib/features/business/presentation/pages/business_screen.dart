import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geovision/core/theme/theme_bloc.dart';
import 'package:geovision/features/addBusiness/bloc/searchlocationBloc/searchlocation_bloc.dart';
import 'package:geovision/features/addBusiness/bloc/searchlocationBloc/searchlocation_event.dart';
import 'package:geovision/features/business/presentation/widget/add_business.dart';

class BusinessScreen extends StatefulWidget {
  const BusinessScreen({super.key});

  @override
  State<BusinessScreen> createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeBloc>().state == ThemeMode.dark;

    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Business',
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/add-business/searchlocation')
                      .then((_) {
                    context.read<LocationBloc>().add(FetchLocationsEvent());
                  });
                },
                icon: Icon(Icons.add_circle,
                    size: 50, color: isDarkMode ? Colors.white : Colors.black),
              ),
            ],
          ),
          Expanded(
              child: Center(
            child: AddBusiness(),
          ))
        ],
      ),
    );
  }
}

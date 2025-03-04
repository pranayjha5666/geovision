import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geovision/core/theme/theme_bloc.dart';
import 'package:geovision/features/addBusiness/bloc/searchlocationBloc/searchlocation_bloc.dart';
import 'package:geovision/features/addBusiness/bloc/searchlocationBloc/searchlocation_event.dart';
import 'package:geovision/widgets/custom_button.dart';
class AddBusiness extends StatelessWidget {
  const AddBusiness({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeBloc>().state == ThemeMode.dark;

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.store,
            size: 40,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          SizedBox(height: 20,),
          Text(
            "No Business Listed Yet",
            style: TextStyle(
              fontSize: 25,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: 10,),
          Text(
            "Discover the best locations and start growing today!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Montserrat',
              color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,

            ),
          ),
          SizedBox(height: 25,),
          CustomButton(onTap: (){
            Navigator.pushNamed(context, '/add-business/searchlocation').then((_) {
              // Reload full list when returning to this page
              context.read<LocationBloc>().add(FetchLocationsEvent());
            });
          }, text: "Add a business",)
        ],
      ),
    );
  }
}
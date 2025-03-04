import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geovision/core/theme/theme_bloc.dart';
import 'package:geovision/features/addBusiness/bloc/searchlocationBloc/searchlocation_bloc.dart';
import 'package:geovision/features/addBusiness/bloc/searchlocationBloc/searchlocation_event.dart';
import 'package:geovision/features/addBusiness/bloc/searchlocationBloc/searchlocation_state.dart';
import 'package:geovision/widgets/custom_textformfield.dart';

class SearchLocation extends StatelessWidget {
  const SearchLocation({super.key});

  Widget build(BuildContext context) {
    final TextEditingController locationController = TextEditingController();
    final isDarkMode = context.watch<ThemeBloc>().state == ThemeMode.dark;


    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search Location",
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextFormField(
              controller: locationController,
              hintText: 'Search Place',
              prefixIcon: Icons.location_on_sharp,
              onChanged: (query) {
                context.read<LocationBloc>().add(FilterLocationsEvent(query));
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<LocationBloc, SearchLocationState>(
              builder: (context, state) {
                if (state is SearchLocationLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SearchLocationError) {
                  return Center(child: Text(state.message));
                } else if (state is SearchLocationLoaded) {
                  return ListView.builder(
                    itemCount: state.locations.length,
                    itemBuilder: (context, index) {
                      final location = state.locations[index];
                      return ListTile(
                        title: Text(location.name),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            "/add-business/location",
                            arguments: location,
                          );
                        },
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}

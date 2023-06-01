import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_example/bloc/airport/map_bloc.dart';
import 'package:map_example/common_widgets/build_list_tile.dart';
import 'package:map_example/constants/status.dart';
import 'package:map_example/screens/map_screen.dart';

// Initial screen that will show to the user
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Example'),
      ),
      // Here watching the 'mapLoaded' variable in state
      // When it is true then it will take to the map screen.
      body: BlocConsumer<MapBloc, MapState>(
        listenWhen: (previous, current) =>
            previous.mapLoaded != current.mapLoaded,
        listener: (context, state) {
          if (state.mapLoaded) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const MapScreen(),
              ),
            );
          }
        },
        buildWhen: (previous, current) =>
            previous.status != current.status ||
            previous.listOfAirports.length != current.listOfAirports.length,
        builder: (context, state) {
          // If state is initial or in-progress then showing progress indicator
          if (state.status.isInitial || state.status.isInProgress) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          // If state is failure or list of the airports are empty then showing error text
          else if (state.status.isFailure || state.listOfAirports.isEmpty) {
            return const Center(
              child: Text('No data found, Please restart the app!'),
            );
          }
          // If list of airports is not empty then showing the list
          return ListView.builder(
            itemCount: state.listOfAirports.length,
            itemBuilder: (context, index) {
              var mapModel = state.listOfAirports[index];
              return GestureDetector(
                // When user taps on the list tile it will pass that airport model to the state
                onTap: () {
                  context.read<MapBloc>().add(
                        LoadMapRequested(airportModel: mapModel),
                      );
                },
                // This will build the list tile with airport model
                child: BuildListTile(mapModel: mapModel),
              );
            },
          );
        },
      ),
    );
  }
}

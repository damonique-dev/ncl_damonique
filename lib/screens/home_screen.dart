import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ncl_damonique/blocs/bloc/cruise_ship_bloc.dart';
import 'package:ncl_damonique/models/cruise_ship_model.dart';
import 'package:ncl_damonique/widgets/cruise_ship_details_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void _cruiseShipButtonPressed(BuildContext context, CruiseShipName ship) {
    context.read<CruiseShipBloc>().add(FetchCruiseShip(ship: ship));
  }

  Widget _buttonRow(BuildContext context) => Row(
        children: [
          for (final ship in CruiseShipName.values) ...[
            const Spacer(),
            ElevatedButton(
                onPressed: () => _cruiseShipButtonPressed(context, ship),
                child: Text(ship.name.toUpperCase())),
          ],
          const Spacer(),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cruise Ships')),
      body: BlocBuilder<CruiseShipBloc, CruiseShipState>(
        builder: (context, state) {
          return Column(
            children: [
              const SizedBox(height: 16.0),
              _buttonRow(context),
              const SizedBox(height: 16.0),
              if (state is CruiseShipLoading) const CircularProgressIndicator(),
              if (state is CruiseShipLoadFailed)
                const Text(
                  "Failed to load Cruise Ship information",
                  style: TextStyle(color: Colors.red),
                ),
              if (state is CruiseShipLoaded)
                CruiseShipDetails(cruiseShip: state.cruiseShip)
            ],
          );
        },
      ),
    );
  }
}

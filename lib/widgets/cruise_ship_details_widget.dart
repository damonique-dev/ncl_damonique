import 'package:flutter/material.dart';
import 'package:ncl_damonique/models/cruise_ship_model.dart';

class CruiseShipDetails extends StatelessWidget {
  final CruiseShip cruiseShip;
  const CruiseShipDetails({Key? key, required this.cruiseShip})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          cruiseShip.shipName,
          style: Theme.of(context).textTheme.headline3,
        ),
        Text(
          "Passenger Capacity: ${cruiseShip.shipFacts.passengerCapacity}",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Text(
          "Crew: ${cruiseShip.shipFacts.crew}",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Text(
          "Inaugeral Date: ${cruiseShip.shipFacts.inauguralDate}",
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ncl_damonique/models/cruise_ship_model.dart';
import 'package:ncl_damonique/widgets/cruise_ship_details_widget.dart';

void main() {
  group("CruiseShipDetailsWidget", () {
    testWidgets('smoke test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
          home: CruiseShipDetails(
              cruiseShip: CruiseShip(
                  shipName: "Ship Name",
                  shipFacts: ShipFacts(
                      passengerCapacity: "1,234",
                      crew: "567",
                      inauguralDate: "2020")))));

      expect(find.text("Ship Name"), findsOneWidget);
      expect(find.text("Passenger Capacity: 1,234"), findsOneWidget);
      expect(find.text("Crew: 567"), findsOneWidget);
      expect(find.text("Inaugeral Date: 2020"), findsOneWidget);
    });
  });
}

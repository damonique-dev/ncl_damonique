import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ncl_damonique/blocs/bloc/cruise_ship_bloc.dart';
import 'package:ncl_damonique/models/cruise_ship_model.dart';

import 'package:ncl_damonique/screens/home_screen.dart';
import 'package:ncl_damonique/services/api_service.dart';
import 'package:ncl_damonique/widgets/cruise_ship_details_widget.dart';

import 'home_screen_test.mocks.dart';

@GenerateMocks([ApiService])
void main() {
  late MockApiService apiService;

  setUp(() {
    apiService = MockApiService();
  });
  group("HomeScreen", () {
    testWidgets('Cruise Details smoke test with cruise ship details',
        (WidgetTester tester) async {
      when(apiService.getCruiseShip(CruiseShipName.escape)).thenAnswer(
          (_) async => CruiseShip(
              shipName: "Ship Name",
              shipFacts: ShipFacts(
                  passengerCapacity: "1,234",
                  crew: "567",
                  inauguralDate: "2020")));

      await tester.pumpWidget(MaterialApp(
        home: BlocProvider(
            create: (_) => CruiseShipBloc(apiService),
            child: const HomeScreen()),
      ));

      expect(find.byType(ElevatedButton), findsNWidgets(3));
      expect(find.byType(CruiseShipDetails), findsNothing);

      await tester.tap(find.text("ESCAPE"));
      await tester.pump();

      expect(find.byType(ElevatedButton), findsNWidgets(3));
      expect(find.byType(CruiseShipDetails), findsOneWidget);
      expect(find.text("Ship Name"), findsOneWidget);
      expect(find.text("Passenger Capacity: 1,234"), findsOneWidget);
      expect(find.text("Crew: 567"), findsOneWidget);
      expect(find.text("Inaugeral Date: 2020"), findsOneWidget);
    });

    testWidgets('Cruise Details smoke test with invalid cruise ship details',
        (WidgetTester tester) async {
      when(apiService.getCruiseShip(CruiseShipName.escape))
          .thenThrow(Exception());

      await tester.pumpWidget(MaterialApp(
        home: BlocProvider(
            create: (_) => CruiseShipBloc(apiService),
            child: const HomeScreen()),
      ));

      expect(find.byType(ElevatedButton), findsNWidgets(3));
      expect(find.byType(CruiseShipDetails), findsNothing);

      await tester.tap(find.text("ESCAPE"));
      await tester.pump();

      expect(find.byType(ElevatedButton), findsNWidgets(3));
      expect(find.byType(CruiseShipDetails), findsNothing);
      expect(
          find.text("Failed to load Cruise Ship information"), findsOneWidget);
    });
  });
}

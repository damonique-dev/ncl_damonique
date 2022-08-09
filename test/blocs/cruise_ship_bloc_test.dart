import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ncl_damonique/blocs/bloc/cruise_ship_bloc.dart';
import 'package:ncl_damonique/models/cruise_ship_model.dart';
import 'package:ncl_damonique/services/api_service.dart';

import 'cruise_ship_bloc_test.mocks.dart';

@GenerateMocks([ApiService])
void main() {
  late MockApiService apiService;

  setUp(() {
    apiService = MockApiService();
  });
  group("CruiseShipBloc", () {
    blocTest(
      'emits [] when nothing is added',
      build: () => CruiseShipBloc(apiService),
      expect: () => [],
    );

    blocTest(
      'emits [CruiseShipLoading, CruiseShipLoaded] when FetchCruiseShip is added with no error thrown',
      build: () => CruiseShipBloc(apiService),
      setUp: () {
        when(apiService.getCruiseShip(CruiseShipName.escape)).thenAnswer(
            (_) async => CruiseShip(
                shipName: "Ship Name",
                shipFacts: ShipFacts(
                    passengerCapacity: "1,234",
                    crew: "567",
                    inauguralDate: "2020")));
      },
      act: ((CruiseShipBloc bloc) =>
          bloc.add(FetchCruiseShip(ship: CruiseShipName.escape))),
      expect: () => [isA<CruiseShipLoading>(), isA<CruiseShipLoaded>()],
    );

    blocTest(
      'emits [CruiseShipLoading, CruiseShipLoadFailed] when FetchCruiseShip is added with error thrown',
      build: () => CruiseShipBloc(apiService),
      setUp: () {
        when(apiService.getCruiseShip(CruiseShipName.escape))
            .thenThrow(Exception());
      },
      act: ((CruiseShipBloc bloc) =>
          bloc.add(FetchCruiseShip(ship: CruiseShipName.escape))),
      expect: () => [isA<CruiseShipLoading>(), isA<CruiseShipLoadFailed>()],
    );
  });
}

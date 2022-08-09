import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ncl_damonique/models/cruise_ship_model.dart';
import 'package:ncl_damonique/services/api_service.dart';

import 'api_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late ApiService underTest;
  late MockClient client;

  setUp(() {
    client = MockClient();
    underTest = ApiService(client);
  });

  group("ApiService", () {
    test("returns CruiseShip on 200 response", () async {
      final cruiseUrl =
          Uri.https(ApiService.baseUrl, '${ApiService.cruiseShipPath}escape');
      const cruiseShipResponseJson = '''{"shipName": "Ship Name", 
              "shipFacts": {"passengerCapacity": "1,234",
              "crew": "567",
              "inauguralDate": "2020"
              }}''';
      when(client.get(cruiseUrl))
          .thenAnswer((_) async => http.Response(cruiseShipResponseJson, 200));
      final expected = CruiseShip(
          shipName: "Ship Name",
          shipFacts: ShipFacts(
              passengerCapacity: "1,234", crew: "567", inauguralDate: "2020"));
      final actual = await underTest.getCruiseShip(CruiseShipName.escape);
      expect(actual, expected);
    });

    test("Service throws error on non-200 response", () {
      final cruiseUrl =
          Uri.https(ApiService.baseUrl, '${ApiService.cruiseShipPath}escape');
      when(client.get(cruiseUrl))
          .thenAnswer((_) async => http.Response("", 400));

      expect(() async => await underTest.getCruiseShip(CruiseShipName.escape),
          throwsException);
    });
  });
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ncl_damonique/models/cruise_ship_model.dart';

class ApiService {
  static const baseUrl = 'www.ncl.com';
  static const cruiseShipPath = '/cms-service/cruise-ships/';

  final http.Client _client;

  ApiService(this._client);

  Future<CruiseShip> getCruiseShip(CruiseShipName shipName) async {
    final url = Uri.https(baseUrl, '$cruiseShipPath${shipName.name}');
    final response = await _client.get(url);
    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);
      return CruiseShip.fromJson(decodedJson);
    } else {
      throw Exception(
          'Unable to get cruise ship: status ${response.statusCode}');
    }
  }
}

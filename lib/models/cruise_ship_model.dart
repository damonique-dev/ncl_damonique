import 'dart:ui';

enum CruiseShipName { sky, bliss, escape }

class CruiseShip {
  final String shipName;
  final ShipFacts shipFacts;

  CruiseShip({
    required this.shipName,
    required this.shipFacts,
  });

  factory CruiseShip.fromJson(Map<String, dynamic> json) => CruiseShip(
        shipName: json['shipName'],
        shipFacts: ShipFacts.fromJson(json['shipFacts']),
      );

  @override
  operator ==(other) =>
      other is CruiseShip &&
      other.shipName == shipName &&
      other.shipFacts == shipFacts;

  @override
  int get hashCode => hashValues(shipName, shipFacts);
}

class ShipFacts {
  final String passengerCapacity;
  final String crew;
  final String inauguralDate;

  ShipFacts({
    required this.passengerCapacity,
    required this.crew,
    required this.inauguralDate,
  });

  factory ShipFacts.fromJson(Map<String, dynamic> json) => ShipFacts(
        passengerCapacity: json['passengerCapacity'],
        crew: json['crew'],
        inauguralDate: json['inauguralDate'],
      );

  @override
  operator ==(other) =>
      other is ShipFacts &&
      other.passengerCapacity == passengerCapacity &&
      other.crew == crew &&
      other.inauguralDate == inauguralDate;

  @override
  int get hashCode => hashValues(passengerCapacity, crew, inauguralDate);
}

part of 'cruise_ship_bloc.dart';

abstract class CruiseShipEvent {}

class FetchCruiseShip extends CruiseShipEvent {
  final CruiseShipName ship;

  FetchCruiseShip({required this.ship});
}

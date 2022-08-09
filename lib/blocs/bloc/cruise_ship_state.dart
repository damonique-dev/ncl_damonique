part of 'cruise_ship_bloc.dart';

abstract class CruiseShipState {}

class CruiseShipInitial extends CruiseShipState {}

class CruiseShipLoading extends CruiseShipState {}

class CruiseShipLoaded extends CruiseShipState {
  final CruiseShip cruiseShip;

  CruiseShipLoaded(this.cruiseShip);
}

class CruiseShipLoadFailed extends CruiseShipState {}

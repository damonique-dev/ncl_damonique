import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ncl_damonique/models/cruise_ship_model.dart';
import 'package:ncl_damonique/services/api_service.dart';

part 'cruise_ship_event.dart';
part 'cruise_ship_state.dart';

class CruiseShipBloc extends Bloc<CruiseShipEvent, CruiseShipState> {
  final ApiService apiService;

  CruiseShipBloc(this.apiService) : super(CruiseShipInitial()) {
    on<FetchCruiseShip>((event, emit) async {
      emit(CruiseShipLoading());
      try {
        final cruiseShip = await apiService.getCruiseShip(event.ship);
        emit(CruiseShipLoaded(cruiseShip));
      } catch (error) {
        emit(CruiseShipLoadFailed());
      }
    });
  }
}

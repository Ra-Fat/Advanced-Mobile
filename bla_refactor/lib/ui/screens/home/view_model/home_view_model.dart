
import 'package:bla_refactor/model/ride_pref/ride_pref.dart';
import 'package:bla_refactor/ui/states/ride_preference_state.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final RidePreferenceState ridePreferenceState;
  late VoidCallback _listener;
  
  HomeViewModel({required this.ridePreferenceState}){
    _init();
  }

  // listen to global state change
  void _init(){
    _listener = (){
      notifyListeners();
    };

    ridePreferenceState.addListener(_listener);
  }

  // get current selected ride preference
  RidePreference? get currentRidePreference => ridePreferenceState.ridePreference;

  // get all history of past ride preference in reverse style
  List<RidePreference> get history => ridePreferenceState.history.reversed.toList();

  // update ride preference
  void setRidePreference(RidePreference ridePreference){
    ridePreferenceState.setRidePreference(ridePreference);
    notifyListeners();
  }


  @override
  void dispose() {
    ridePreferenceState.removeListener(_listener);
    super.dispose();
  }

}
import 'package:bla_refactor/data/repositories/ride_preference/ride_preference_repository.dart';
import 'package:bla_refactor/model/ride_pref/ride_pref.dart';
import 'package:flutter/material.dart';

class RidePreferenceState extends ChangeNotifier {
  final RidePreferenceRepository ridePrefRepository;

  RidePreferenceState({required this.ridePrefRepository}) {
    _init();
  }

  List<RidePreference> _preferenceHistory  = [];

  RidePreference? _currentRidePreference;

  void _init() {
    _preferenceHistory  = ridePrefRepository.getAllPreferenceHistory();
    notifyListeners();
  }
  

  List<RidePreference> get history => _preferenceHistory ;

  RidePreference? get ridePreference => _currentRidePreference;

  int maxAllowedSeats = 8;


  // set current ride preference
  void setRidePreference(RidePreference ridePreference){
    if(_currentRidePreference == ridePreference) return;
    
    _currentRidePreference =  ridePreference;
    _preferenceHistory.add(ridePreference);
    ridePrefRepository.addPreferenceToHistory(ridePreference);
    
    notifyListeners();
  }
}
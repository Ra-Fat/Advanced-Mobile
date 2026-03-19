import 'package:bla_refactor/data/repositories/ride_pref/ride_pref_repository.dart';
import 'package:bla_refactor/model/ride_pref/ride_pref.dart';
import 'package:flutter/material.dart';

class RidePreferenceState extends ChangeNotifier {
  final RidePrefRepository ridePrefRepository;

  RidePreferenceState({required this.ridePrefRepository}) {
    _init();
  }

  // store history from fetching
  List<RidePreference> _history = [];

  RidePreference? _currentRidePreference;

  int maxAllowedSeats = 8;

  List<RidePreference> get history => _history;

  RidePreference? get ridePreference => _currentRidePreference;

  Future<void> _init() async {
    _history = await ridePrefRepository.getAllPreferenceHistory();
    
    notifyListeners();
  }

  // set current ride preference
  Future<void> setRidePreference(RidePreference ridePreference) async{
    if(_currentRidePreference == ridePreference) return;
    
    _currentRidePreference =  ridePreference;
    // store history into repo
    
    await ridePrefRepository.addPreferenceToHistory(ridePreference);
    
    notifyListeners();
  }
}
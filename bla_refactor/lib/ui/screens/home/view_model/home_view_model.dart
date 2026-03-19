import 'package:bla_refactor/model/ride_pref/ride_pref.dart';
import 'package:bla_refactor/ui/screens/rides_selection/rides_selection_screen.dart';
import 'package:bla_refactor/ui/states/ride_preference_state.dart';
import 'package:bla_refactor/utils/animations_util.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final RidePreferenceState _ridepreferencesState;

  HomeViewModel({required RidePreferenceState ridepreferencesState})
  : _ridepreferencesState = ridepreferencesState {
    _ridepreferencesState.addListener(_onRidePrefChanged);
  }

  void _onRidePrefChanged() {
    notifyListeners();
  }

  RidePreference? get currentPreference => _ridepreferencesState.ridePreference;
  List<RidePreference> get history => _ridepreferencesState.history;


  void onRidePrefSelected( BuildContext context, RidePreference selectedPreference,) async {
    _ridepreferencesState.setRidePreference(selectedPreference);

    await Navigator.of(
      context,
    ).push(AnimationUtils.createBottomToTopRoute(RidesSelectionScreen()));

    notifyListeners();
  }

  @override
  void dispose() {
    _ridepreferencesState.removeListener(_onRidePrefChanged);
    super.dispose();
  }
}
import '../../../model/ride_pref/ride_pref.dart';

abstract class RidePrefRepository {
  
  // get all preference history
  Future<List<RidePreference>> getAllPreferenceHistory();

  // add preference into history object
  Future<void> addPreferenceToHistory(RidePreference ridePreference);
}
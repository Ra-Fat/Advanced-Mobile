import '../../../model/ride_pref/ride_pref.dart';

abstract class RidePreferenceRepository {
  
  // get all preference history
  List<RidePreference> getAllPreferenceHistory();

  // add preference into history object
  void addPreferenceToHistory(RidePreference ridePreference);
}
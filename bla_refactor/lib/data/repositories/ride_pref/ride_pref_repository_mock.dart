import 'package:bla_refactor/data/repositories/ride_pref/ride_pref_repository.dart';
import 'package:bla_refactor/model/ride_pref/ride_pref.dart';

class RidePrefRepositoryMock implements RidePrefRepository {

  static final List<RidePreference> _preferenceHistory = [];

  @override
  Future<List<RidePreference>> getAllPreferenceHistory() async {
    try {
      return _preferenceHistory;
    } catch (e) {
      throw Exception('No Ride Preference');
    }
  }


  @override
  Future<void> addPreferenceToHistory(RidePreference ridePreference) async {
    try {
      _preferenceHistory.add(ridePreference);
    } catch (e) {
      throw Exception('Error to add Ride Preference.');
    }
  }

}
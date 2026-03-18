import 'package:bla_refactor/model/ride_pref/ride_pref.dart';

import '../../../model/ride/ride.dart';

abstract class RideRepository {
  // get all available rides.
  Future<List<Ride>> getAllRides();

  // get matching ride from user preference
  Future<List<Ride>> getRidesFor(RidePreference ridePref);
}
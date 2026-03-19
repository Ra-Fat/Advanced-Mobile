import 'package:bla_refactor/model/ride_pref/ride_pref.dart';

import '../../../model/ride/ride.dart';

abstract class RideRepository {
  // get all available rides.
  List<Ride> getAllRides();

  // get matching ride from user preference
  List<Ride> getRidesFor(RidePreference ridePref);
}
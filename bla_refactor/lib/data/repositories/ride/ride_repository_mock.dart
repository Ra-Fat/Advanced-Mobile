import 'package:bla_refactor/data/repositories/ride/ride_repository.dart';
import 'package:bla_refactor/model/ride/ride.dart';
import 'package:bla_refactor/model/ride_pref/ride_pref.dart';
import '../../dummy_data.dart';


class RideRepositoryMock implements RideRepository {
  
  @override
  Future<List<Ride>> getAllRides() async {
    try {
      final List<Ride> allRides = fakeRides;
      return allRides;
    } catch (err) {
      throw Exception('No Available Ride.');
    }
  }

  @override
  Future<List<Ride>> getRidesFor(RidePreference ridePreference) async {
    try {
      final allRides = await getAllRides();
      return allRides
          .where(
            (ride) =>
                ride.departureLocation == ridePreference.departure &&
                ride.arrivalLocation == ridePreference.arrival &&
                ride.availableSeats >= ridePreference.requestedSeats,
          )
          .toList();
    } catch (err) {
      throw Exception('Rides not found.');
    }
  }
} 
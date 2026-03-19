import 'package:bla_refactor/data/repositories/location/location_repository.dart';
import 'package:bla_refactor/data/repositories/ride/ride_repository.dart';
import 'package:bla_refactor/data/repositories/user/user_repository.dart';
import 'package:bla_refactor/model/ride/locations.dart';
import 'package:bla_refactor/model/ride/ride.dart';
import 'package:bla_refactor/model/ride_pref/ride_pref.dart';
import 'package:bla_refactor/model/user/user.dart';


class RideRepositoryMock implements RideRepository {

  final LocationRepository locationRepository;
  final UserRepository userRepository;


  RideRepositoryMock({
    required this.locationRepository,
    required this.userRepository,
  }) {
    _locations = locationRepository.getAlllocations();
    _users = userRepository.getAllUsers();
  }


  late final List<Location> _locations;
  late final List<User> _users;


  List<Ride> get rides => [
    Ride(
      departureLocation: _locations[0], // London
      departureDate: DateTime.now().add(Duration(hours: 3)),
      arrivalLocation: locationRepository.getAlllocations()[19], // Paris
      arrivalDateTime: DateTime.now().add(Duration(hours: 8)),
      driver: _users[0],
      availableSeats: 2,
      pricePerSeat: 25.0,
    ),

    Ride(
      departureLocation: _locations[0], // London
      departureDate: DateTime.now().add(Duration(hours: 10)),
      arrivalLocation: _locations[19], // Paris
      arrivalDateTime: DateTime.now().add(Duration(hours: 9)),
      driver: _users[1],
      availableSeats: 1,
      pricePerSeat: 30.0,
    ),

    Ride(
      departureLocation: _locations[2], // Birmingham
      departureDate: DateTime.now().add(Duration(days: 1)),
      arrivalLocation: _locations[22], // Toulouse
      arrivalDateTime: DateTime.now().add(Duration(days: 1, hours: 4)),
      driver: _users[2],
      availableSeats: 2,
      pricePerSeat: 22.5,
    ),

    Ride(
      departureLocation: _locations[3], // Liverpool
      departureDate: DateTime.now().add(Duration(days: 2)),
      arrivalLocation: _locations[23], // Nice
      arrivalDateTime: DateTime.now().add(Duration(days: 2, hours: 6)),
      driver: _users[3],
      availableSeats: 3,
      pricePerSeat: 35.0,
    ),

    Ride(
      departureLocation: _locations[4], // Leeds
      departureDate: DateTime.now().add(Duration(days: 2, hours: 5)),
      arrivalLocation: _locations[24], // Nantes
      arrivalDateTime: DateTime.now().add(Duration(days: 2, hours: 10)),
      driver: _users[4],
      availableSeats: 4,
      pricePerSeat: 28.0,
    ),

    Ride(
      departureLocation: _locations[5], // Glasgow
      departureDate: DateTime.now().add(Duration(days: 3)),
      arrivalLocation: _locations[25], // Strasbourg
      arrivalDateTime: DateTime.now().add(Duration(days: 3, hours: 7)),
      driver: _users[5],
      availableSeats: 3,
      pricePerSeat: 40.0,
    ),

    Ride(
      departureLocation: _locations[6], // Sheffield
      departureDate: DateTime.now().add(Duration(days: 3, hours: 2)),
      arrivalLocation: _locations[26], // Montpellier
      arrivalDateTime: DateTime.now().add(Duration(days: 3, hours: 8)),
      driver: _users[0],
      availableSeats: 2,
      pricePerSeat: 26.0,
    ),

    Ride(
      departureLocation: _locations[7], // Bristol
      departureDate: DateTime.now().add(Duration(days: 4)),
      arrivalLocation: _locations[27], // Bordeaux
      arrivalDateTime: DateTime.now().add(Duration(days: 4, hours: 6)),
      driver: _users[1],
      availableSeats: 3,
      pricePerSeat: 29.0,
    ),

    Ride(
      departureLocation: _locations[8], // Edinburgh
      departureDate: DateTime.now().add(Duration(days: 4, hours: 4)),
      arrivalLocation: _locations[28], // Lille
      arrivalDateTime: DateTime.now().add(Duration(days: 4, hours: 9)),
      driver: _users[2],
      availableSeats: 4,
      pricePerSeat: 27.5,
    ),

    Ride(
      departureLocation: _locations[9], // Leicester
      departureDate: DateTime.now().add(Duration(days: 5)),
      arrivalLocation: _locations[29], // Rennes
      arrivalDateTime: DateTime.now().add(Duration(days: 5, hours: 5)),
      driver: _users[3],
      availableSeats: 3,
      pricePerSeat: 24.0,
    ),
];
  
  @override
  List<Ride> getAllRides() {
    return List.unmodifiable(rides);
  }

  @override
  List<Ride> getRidesFor(RidePreference ridePreference) {
    try {
      final allRides = getAllRides();
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
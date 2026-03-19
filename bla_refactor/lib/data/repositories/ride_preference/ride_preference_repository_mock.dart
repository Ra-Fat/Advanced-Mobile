import 'package:bla_refactor/data/repositories/location/location_repository.dart';
import 'package:bla_refactor/data/repositories/ride_preference/ride_preference_repository.dart';
import 'package:bla_refactor/model/ride/locations.dart';
import 'package:bla_refactor/model/ride_pref/ride_pref.dart';

class RidePreferenceRepositoryMock implements RidePreferenceRepository {

  final LocationRepository locationRepository;

  RidePreferenceRepositoryMock({
    required this.locationRepository,
  }) {
    _locations = locationRepository.getAlllocations();
  }

  late final List<Location> _locations;

  late final List<RidePreference> _ridePreferences = [
    RidePreference(
      departure: _locations[0], // London
      departureDate: DateTime.now().add(Duration(days: 1)), // Tomorrow
      arrival: _locations[3], // Paris
      requestedSeats: 2,
    ),
    RidePreference(
      departure: _locations[1], // Manchester
      departureDate: DateTime.now().add(Duration(days: 7)), // Next week
      arrival: _locations[4], // Lyon
      requestedSeats: 3,
    ),
    RidePreference(
      departure: _locations[2], // Birmingham
      departureDate: DateTime.now(), // Today
      arrival: _locations[5], // Marseille
      requestedSeats: 1,
    ),
    RidePreference(
      departure: _locations[0], // London
      departureDate: DateTime.now().add(Duration(days: 1)), // Tomorrow
      arrival: _locations[3], // Paris
      requestedSeats: 2,
    ),
    RidePreference(
      departure: _locations[4], // Manchester
      departureDate: DateTime.now().add(Duration(days: 7)), // Next week
      arrival: _locations[0], // Lyon
      requestedSeats: 3,
    ),
    RidePreference(
      departure: _locations[5], // Birmingham
      departureDate: DateTime.now(), // Today
      arrival: _locations[1], // Marseille
      requestedSeats: 1,
    ),
  ];


  @override
  List<RidePreference> getAllPreferenceHistory() {
    return List.unmodifiable(_ridePreferences);
  }

  @override
  void addPreferenceToHistory(RidePreference ridePreference) {
    _ridePreferences.add(ridePreference);
  }

}
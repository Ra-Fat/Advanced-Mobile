import '../../../model/ride/locations.dart';

abstract class LocationRepository {
  // used to get all location data
  Future<List<Location>> getAlllocations();
}
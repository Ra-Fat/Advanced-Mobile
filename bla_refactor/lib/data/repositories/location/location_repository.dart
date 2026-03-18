import '../../../model/ride/locations.dart';

abstract class LocationRepository {
  Future<List<Location>> getAlllocations();
  List<Location> getSearchLocations(String search);
}
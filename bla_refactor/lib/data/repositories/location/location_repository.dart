import '../../../model/ride/locations.dart';

abstract class LocationRepository {
  List<Location> getAlllocations();
  List<Location> getSearchLocations(String search);
}
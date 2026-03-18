import 'package:bla_refactor/data/repositories/location/location_repository.dart';
import 'package:bla_refactor/model/ride/locations.dart';
import '../../dummy_data.dart';


class LocationRepositoryMock implements LocationRepository {

  final List<Location> _locations = fakeLocations;

   @override
  Future<List<Location>> getAlllocations() async {
    try {
      await Future.delayed(Duration(milliseconds: 300));
      return _locations;
    } catch (err) {
      throw Exception("Failed to load locations: $err");
    }
  }

  @override
  List<Location> getSearchLocations(String search) {
    try {
      return _locations
          .where((l) => l.name.toLowerCase().contains(search.toLowerCase()))
          .toList();
    } catch (err) {
      throw Exception("Search failed: $err");
    }
  }
}
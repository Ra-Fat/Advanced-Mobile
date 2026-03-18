import 'package:bla_refactor/data/repositories/location/location_repository.dart';
import 'package:bla_refactor/model/ride/locations.dart';
import '../../dummy_data.dart';


class LocationRepositoryMock implements LocationRepository {

  @override
  Future<List<Location>> getAlllocations() async{
    try{
      final List<Location> availableLocation = fakeLocations;
      return availableLocation;
    }catch(err){
      throw Exception("locations not available.");
    }
  }
}
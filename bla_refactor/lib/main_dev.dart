import 'package:bla_refactor/data/repositories/location/location_repository_mock.dart';
import 'package:provider/provider.dart';
import 'package:nested/nested.dart';
import 'package:bla_refactor/data/repositories/ride/ride_repository_mock.dart';
import 'package:bla_refactor/data/repositories/ride_pref/ride_pref_repository_mock.dart';
import 'package:bla_refactor/main_common.dart';
import 'data/repositories/location/location_repository.dart';
import 'data/repositories/ride/ride_repository.dart';
import 'data/repositories/ride_pref/ride_pref_repository.dart';


List<SingleChildWidget> get devProviders {
  
  return [

    // Inject location repository
    Provider<LocationRepository>(create: (_) => LocationRepositoryMock(),),

    // Inject ride repository
    Provider<RideRepository>(create: (_) => RideRepositoryMock()),

    // Inject ride preference repository
    Provider<RidePrefRepository>(create: (_) => RidePrefRepositoryMock()),

  ];
}

void main(){
  mainCommon(devProviders);
}
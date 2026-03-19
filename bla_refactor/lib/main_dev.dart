import 'package:bla_refactor/data/repositories/location/location_repository_mock.dart';
import 'package:bla_refactor/ui/states/ride_preference_state.dart';
import 'package:provider/provider.dart';
import 'package:bla_refactor/data/repositories/ride/ride_repository_mock.dart';
import 'package:bla_refactor/data/repositories/ride_pref/ride_pref_repository_mock.dart';
import 'package:bla_refactor/main_common.dart';
import 'data/repositories/location/location_repository.dart';
import 'data/repositories/ride/ride_repository.dart';
import 'data/repositories/ride_pref/ride_pref_repository.dart';


List<InheritedProvider> get devProviders {

    final ridePrefRepository = RidePrefRepositoryMock();

  return [

    // Inject location repository
    Provider<LocationRepository>(create: (_) => LocationRepositoryMock(),),

    // Inject ride repository
    Provider<RideRepository>(create: (_) => RideRepositoryMock()),

    // Inject ride preference repository
    Provider<RidePrefRepository>(create: (_) => ridePrefRepository),

    // Inject ride preference state
    ChangeNotifierProvider<RidePreferenceState>(create: (_) => RidePreferenceState(ridePrefRepository: ridePrefRepository))

  ];
}

void main(){
  mainCommon(devProviders);
}
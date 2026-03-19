import 'package:bla_refactor/data/repositories/location/location_repository_mock.dart';
import 'package:bla_refactor/data/repositories/user/user_repository.dart';
import 'package:bla_refactor/data/repositories/user/user_repository_mock.dart';
import 'package:bla_refactor/ui/states/ride_preference_state.dart';
import 'package:provider/provider.dart';
import 'package:bla_refactor/data/repositories/ride/ride_repository_mock.dart';
import 'package:bla_refactor/data/repositories/ride_preference/ride_preference_repository_mock.dart';
import 'package:bla_refactor/main_common.dart';
import 'data/repositories/location/location_repository.dart';
import 'data/repositories/ride/ride_repository.dart';
import 'data/repositories/ride_preference/ride_preference_repository.dart';


List<InheritedProvider> get devProviders {

  final locationRepository = LocationRepositoryMock();
  final userRepository = UserRepositoryMock();
  final ridePrefRepository = RidePreferenceRepositoryMock(locationRepository: locationRepository);

  return [

    // Inject location repository
    Provider<LocationRepository>(create: (_) => locationRepository,),

    // Inject ride repository
    Provider<RideRepository>( create: (context) => 
      RideRepositoryMock(
        locationRepository: locationRepository,
        userRepository: userRepository,
      ),
    ),

    // Inject ride preference repository
    Provider<RidePreferenceRepository>(create: (_) => ridePrefRepository),

    // Inject user repository
    Provider<UserRepository>( create: (_) => userRepository,),

    // Inject ride preference state
    ChangeNotifierProvider<RidePreferenceState>(create: (_) => RidePreferenceState(ridePrefRepository: ridePrefRepository))

  ];
}

void main(){
  mainCommon(devProviders);
}